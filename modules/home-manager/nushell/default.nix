{ pkgs
, ...
}: {
  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        lla = "ls -la";
      };
      extraConfig = ''
        # Shared environment variable with default
        $env.MONGO_AWS_PROFILE = ($env.MONGO_AWS_PROFILE | default 'iamuser')

        # Function to generate MongoDB connection string
        def build-connection-string [roleARN: string = "", clusterID: string = "", projectID: string = ""] {
            let role_session_name = "MongoSession"
            let credentials = (aws sts assume-role 
                --profile $env.MONGO_AWS_PROFILE
                --role-arn $roleARN
                --role-session-name $role_session_name
                --duration-seconds 43200
                --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]'
                --output text
                | lines 
                | first)
    
            let [access_key secret_key session_token] = ($credentials | split row " ")
    
            $"mongodb+srv://($access_key | url encode):($secret_key | url encode)@($clusterID).($projectID).mongodb.net/?authMechanismProperties=AWS_SESSION_TOKEN:($session_token | url encode)&authSource=$external&authMechanism=MONGODB-AWS"
        }

        # Open MongoDB Compass with connection string
        def open-mongodb-compass [roleARN: string = "", clusterID: string = "", projectID: string = ""] {
            let connection_string = (build-connection-string $roleARN $clusterID $projectID)
            open -na "MongoDB Compass" --args $connection_string
            print $"(ansi green)SUCCESS: MongoDB Compass is opening with the connection string.(ansi reset)"
        }

        # Get cluster configuration based on role
        def get-cluster [role: string = ""] {
            let dev_cluster = {
                clusterID: "development"
                projectID: "yjoqm"
            }
            let qa_cluster = {
                clusterID: "qa"
                projectID: "p0mwj"
            }
    
            match $role {
                "dev-rw" | "" => { 
                    $dev_cluster | merge { roleARN: "arn:aws:iam::242061917130:role/mongodb-development-rw" }
                }
                "qa-ro" => {
                    $qa_cluster | merge { roleARN: "arn:aws:iam::242061917130:role/mongodb-qa-ro" }
                }
                "qa-rw" => {
                    $qa_cluster | merge { roleARN: "arn:aws:iam::242061917130:role/mongodb-qa-rw" }
                }
                _ => {
                    print $"(ansi red)FAILED: ($role) is not a valid role. Please choose from: 'dev-rw', 'qa-ro', 'qa-rw', or leave it empty for 'dev-rw'.(ansi reset)"
                    null
                }
            }
        }

        # Main function to connect to MongoDB
        export def connect-to-mongo [role: string = ""] {
            let cluster_config = (get-cluster $role)
            if ($cluster_config != null) {
                $env.clusterID = $cluster_config.clusterID
                $env.projectID = $cluster_config.projectID
                $env.roleARN = $cluster_config.roleARN
                open-mongodb-compass
                0
            } else {
                1
            }
        }
      '';
      plugins = with pkgs; [
        nushellPlugins.formats
        nushellPlugins.gstat
        nushellPlugins.highlight
        nushellPlugins.query
        # nushellPlugins.skim # incompatible version
        # nushellPlugins.units # incompatible version
      ];
    };
  };
}
