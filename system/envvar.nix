let
  secrets = import ../load-secrets.nix;
  shared = import ../shared.nix;
in {
  environment.variables = {
    GITHUB_TOKEN = secrets.github_token;
    AWS_ACCESS_KEY_ID = secrets.aws_access_key_id;
    AWS_SECRET_ACCESS_KEY = secrets.aws_secret_access_key;
    DIGITAL_OCEAN_TOKEN = secrets.digital_ocean;
    DIGITAL_OCEAN_AUTH_TOKEN = secrets.digital_ocean;
    DOCKER_ID_USER = "kennykwey";
    PATH = "~/.npm-packages/bin:~/.config/composer/vendor/bin/:$PATH";
    # Need for increase bash history size
    HISTSIZE = "10000";
    HISTFILESIZE = "10000";
  };
}
