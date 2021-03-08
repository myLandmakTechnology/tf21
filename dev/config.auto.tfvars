    #App Variable definitions here 
    #(command line arguments override)
    vpc_cidr            = "10.200.0.0/19"
    region              = "us-west-2"
    private_a           = "10.200.16.0/22"
    private_b           = "10.200.12.0/22"
    private_c           = "10.200.20.0/22"
    public_a            = "10.200.0.0/22"
    public_b            = "10.200.4.0/22"
    public_c            = "10.200.8.0/22"
    instance_size       = "t2.medium"
    ec2_key             = "dev-wb-Blitline2-app"
    Blitline2_env             = "dev"
    ingress_access      = ["168.161.192.0/21","168.161.18.1/32","168.161.22.1/32","168.161.200.15/32"]
    #peer_id             = "vpc-0062376115968fcfc"
    #peer_cidr           = "10.176.218.0/24"