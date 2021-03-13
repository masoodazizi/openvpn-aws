aws_profile = "default"
## AWS profile initialized by AWS CLI. If left commented, the AWS access key and secret key (next params) will be used.

# aws_access_key = ""
# aws_secret_key = ""
## If aws_profile is not defined (="") or commented, AWS aaccess key and secret key used for AWS API access.
## WARNING! These values are SENSITIVE and must NEVER stored/pushed to a repository. Thus, aws_profile method is recommended.

# aws_region = "eu-central-1"
## AWS Region code. The default is 'eu-central-1' which is Frankfurt region. Listed in AWS documentations.

# instance_type = "t2.micro"
## Type of virtual machine i.e. CPU, RAM, etc. Only 't2.micro' is included in free tier. If left commented, the default would be 't2.micro'. Listed in AWS documentations.

openvpn_ami = "ami-xxxxxxxxxxxxxxxxx"
## It should be defined for the specific product which is subscribed in AWS Marketplace. If left commented, the default would be an image in eu-central-1.

# vpn_username = "yourname"
## The username for openvpn access and administration. If left commected, the default would be 'openvpn'

# vpn_password = ""
## The password for openvpn access and administration. If left commected, it will be randomly generated and showed in output.

# enable_ssh_access = true
## If it is required to login to the server, this must be true and public_key must be defined!

# public_key = "ssh-rsa AAAAB3Nza....."
## The ssh key will be required to login to the server. Only public key, the PRIVATE key must NOT be revealed! Use 'ssh-keygen' to generate the key pair.
