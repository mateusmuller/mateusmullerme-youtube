import pulumi
import pulumi_aws as aws
import json

cluster = aws.ecs.Cluster("live-pulumi")

task_definition = aws.ecs.TaskDefinition("nginx-pulumi",
    family="nginx-pulumi",
    container_definitions=json.dumps([
        {
            "name": "nginx",
            "image": "nginx"
        }
    ]),
    requires_compatibilities=["FARGATE"],
    network_mode="awsvpc",
    cpu="1024",
    memory="2048")

security_group = aws.ec2.SecurityGroup("allow_http",
    vpc_id="vpc-<id>",
    ingress=[aws.ec2.SecurityGroupIngressArgs(
        description="HTTP outside world",
        from_port=80,
        to_port=80,
        protocol="tcp",
        cidr_blocks=["0.0.0.0/0"]
    )],
    egress=[aws.ec2.SecurityGroupEgressArgs(
        from_port=0,
        to_port=0,
        protocol="-1",
        cidr_blocks=["0.0.0.0/0"]
    )])

service = aws.ecs.Service("nginx-service",
    cluster=cluster.id,
    task_definition=task_definition.arn,
    desired_count=1,
    launch_type="FARGATE",
    name="nginx-service",
    network_configuration=aws.ecs.service.ServiceNetworkConfigurationArgs(
      subnets=[
        "subnet-<id>"
      ],
      security_groups=[
        security_group.id
      ],
      assign_public_ip=True
    ))
