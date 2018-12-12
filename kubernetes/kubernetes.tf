locals = {
  cluster_name                 = "labroots.inkeystone.com"
  master_autoscaling_group_ids = ["${aws_autoscaling_group.master-us-east-2a-masters-labroots-inkeystone-com.id}"]
  master_security_group_ids    = ["${aws_security_group.masters-labroots-inkeystone-com.id}"]
  masters_role_arn             = "${aws_iam_role.masters-labroots-inkeystone-com.arn}"
  masters_role_name            = "${aws_iam_role.masters-labroots-inkeystone-com.name}"
  node_autoscaling_group_ids   = ["${aws_autoscaling_group.nodes-labroots-inkeystone-com.id}"]
  node_security_group_ids      = ["${aws_security_group.nodes-labroots-inkeystone-com.id}"]
  node_subnet_ids              = ["${aws_subnet.us-east-2a-labroots-inkeystone-com.id}", "${aws_subnet.us-east-2b-labroots-inkeystone-com.id}", "${aws_subnet.us-east-2c-labroots-inkeystone-com.id}"]
  nodes_role_arn               = "${aws_iam_role.nodes-labroots-inkeystone-com.arn}"
  nodes_role_name              = "${aws_iam_role.nodes-labroots-inkeystone-com.name}"
  region                       = "us-east-2"
  route_table_public_id        = "${aws_route_table.labroots-inkeystone-com.id}"
  subnet_us-east-2a_id         = "${aws_subnet.us-east-2a-labroots-inkeystone-com.id}"
  subnet_us-east-2b_id         = "${aws_subnet.us-east-2b-labroots-inkeystone-com.id}"
  subnet_us-east-2c_id         = "${aws_subnet.us-east-2c-labroots-inkeystone-com.id}"
  vpc_id                       = "vpc-0ef5e6a5916de5eac"
}

output "cluster_name" {
  value = "labroots.inkeystone.com"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-us-east-2a-masters-labroots-inkeystone-com.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-labroots-inkeystone-com.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-labroots-inkeystone-com.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-labroots-inkeystone-com.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-labroots-inkeystone-com.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-labroots-inkeystone-com.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-east-2a-labroots-inkeystone-com.id}", "${aws_subnet.us-east-2b-labroots-inkeystone-com.id}", "${aws_subnet.us-east-2c-labroots-inkeystone-com.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-labroots-inkeystone-com.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-labroots-inkeystone-com.name}"
}

output "region" {
  value = "us-east-2"
}

output "route_table_public_id" {
  value = "${aws_route_table.labroots-inkeystone-com.id}"
}

output "subnet_us-east-2a_id" {
  value = "${aws_subnet.us-east-2a-labroots-inkeystone-com.id}"
}

output "subnet_us-east-2b_id" {
  value = "${aws_subnet.us-east-2b-labroots-inkeystone-com.id}"
}

output "subnet_us-east-2c_id" {
  value = "${aws_subnet.us-east-2c-labroots-inkeystone-com.id}"
}

output "vpc_id" {
  value = "vpc-0ef5e6a5916de5eac"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_autoscaling_group" "master-us-east-2a-masters-labroots-inkeystone-com" {
  name                 = "master-us-east-2a.masters.labroots.inkeystone.com"
  launch_configuration = "${aws_launch_configuration.master-us-east-2a-masters-labroots-inkeystone-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-2a-labroots-inkeystone-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "labroots.inkeystone.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-2a.masters.labroots.inkeystone.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-2a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-labroots-inkeystone-com" {
  name                 = "nodes.labroots.inkeystone.com"
  launch_configuration = "${aws_launch_configuration.nodes-labroots-inkeystone-com.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-east-2a-labroots-inkeystone-com.id}", "${aws_subnet.us-east-2b-labroots-inkeystone-com.id}", "${aws_subnet.us-east-2c-labroots-inkeystone-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "labroots.inkeystone.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.labroots.inkeystone.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-labroots-inkeystone-com" {
  availability_zone = "us-east-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                               = "labroots.inkeystone.com"
    Name                                            = "a.etcd-events.labroots.inkeystone.com"
    "k8s.io/etcd/events"                            = "a/a"
    "k8s.io/role/master"                            = "1"
    "kubernetes.io/cluster/labroots.inkeystone.com" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-labroots-inkeystone-com" {
  availability_zone = "us-east-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                               = "labroots.inkeystone.com"
    Name                                            = "a.etcd-main.labroots.inkeystone.com"
    "k8s.io/etcd/main"                              = "a/a"
    "k8s.io/role/master"                            = "1"
    "kubernetes.io/cluster/labroots.inkeystone.com" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-labroots-inkeystone-com" {
  name = "masters.labroots.inkeystone.com"
  role = "${aws_iam_role.masters-labroots-inkeystone-com.name}"
}

resource "aws_iam_instance_profile" "nodes-labroots-inkeystone-com" {
  name = "nodes.labroots.inkeystone.com"
  role = "${aws_iam_role.nodes-labroots-inkeystone-com.name}"
}

resource "aws_iam_role" "masters-labroots-inkeystone-com" {
  name               = "masters.labroots.inkeystone.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.labroots.inkeystone.com_policy")}"
}

resource "aws_iam_role" "nodes-labroots-inkeystone-com" {
  name               = "nodes.labroots.inkeystone.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.labroots.inkeystone.com_policy")}"
}

resource "aws_iam_role_policy" "masters-labroots-inkeystone-com" {
  name   = "masters.labroots.inkeystone.com"
  role   = "${aws_iam_role.masters-labroots-inkeystone-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.labroots.inkeystone.com_policy")}"
}

resource "aws_iam_role_policy" "nodes-labroots-inkeystone-com" {
  name   = "nodes.labroots.inkeystone.com"
  role   = "${aws_iam_role.nodes-labroots-inkeystone-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.labroots.inkeystone.com_policy")}"
}

resource "aws_key_pair" "kubernetes-labroots-inkeystone-com-e9017d15359a6ec202c7c3bdda754bb1" {
  key_name   = "kubernetes.labroots.inkeystone.com-e9:01:7d:15:35:9a:6e:c2:02:c7:c3:bd:da:75:4b:b1"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.labroots.inkeystone.com-e9017d15359a6ec202c7c3bdda754bb1_public_key")}"
}

resource "aws_launch_configuration" "master-us-east-2a-masters-labroots-inkeystone-com" {
  name_prefix                 = "master-us-east-2a.masters.labroots.inkeystone.com-"
  image_id                    = "ami-094be7cc0306aa98e"
  instance_type               = "c4.large"
  key_name                    = "${aws_key_pair.kubernetes-labroots-inkeystone-com-e9017d15359a6ec202c7c3bdda754bb1.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-labroots-inkeystone-com.id}"
  security_groups             = ["${aws_security_group.masters-labroots-inkeystone-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-2a.masters.labroots.inkeystone.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-labroots-inkeystone-com" {
  name_prefix                 = "nodes.labroots.inkeystone.com-"
  image_id                    = "ami-094be7cc0306aa98e"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-labroots-inkeystone-com-e9017d15359a6ec202c7c3bdda754bb1.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-labroots-inkeystone-com.id}"
  security_groups             = ["${aws_security_group.nodes-labroots-inkeystone-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.labroots.inkeystone.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.labroots-inkeystone-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "igw-0b7c3eadd50946d21"
}

resource "aws_route_table" "labroots-inkeystone-com" {
  vpc_id = "vpc-0ef5e6a5916de5eac"

  tags = {
    KubernetesCluster                               = "labroots.inkeystone.com"
    Name                                            = "labroots.inkeystone.com"
    "kubernetes.io/cluster/labroots.inkeystone.com" = "owned"
    "kubernetes.io/kops/role"                       = "public"
  }
}

resource "aws_route_table_association" "us-east-2a-labroots-inkeystone-com" {
  subnet_id      = "${aws_subnet.us-east-2a-labroots-inkeystone-com.id}"
  route_table_id = "${aws_route_table.labroots-inkeystone-com.id}"
}

resource "aws_route_table_association" "us-east-2b-labroots-inkeystone-com" {
  subnet_id      = "${aws_subnet.us-east-2b-labroots-inkeystone-com.id}"
  route_table_id = "${aws_route_table.labroots-inkeystone-com.id}"
}

resource "aws_route_table_association" "us-east-2c-labroots-inkeystone-com" {
  subnet_id      = "${aws_subnet.us-east-2c-labroots-inkeystone-com.id}"
  route_table_id = "${aws_route_table.labroots-inkeystone-com.id}"
}

resource "aws_security_group" "masters-labroots-inkeystone-com" {
  name        = "masters.labroots.inkeystone.com"
  vpc_id      = "vpc-0ef5e6a5916de5eac"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                               = "labroots.inkeystone.com"
    Name                                            = "masters.labroots.inkeystone.com"
    "kubernetes.io/cluster/labroots.inkeystone.com" = "owned"
  }
}

resource "aws_security_group" "nodes-labroots-inkeystone-com" {
  name        = "nodes.labroots.inkeystone.com"
  vpc_id      = "vpc-0ef5e6a5916de5eac"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                               = "labroots.inkeystone.com"
    Name                                            = "nodes.labroots.inkeystone.com"
    "kubernetes.io/cluster/labroots.inkeystone.com" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-labroots-inkeystone-com.id}"
  source_security_group_id = "${aws_security_group.masters-labroots-inkeystone-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-labroots-inkeystone-com.id}"
  source_security_group_id = "${aws_security_group.masters-labroots-inkeystone-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-labroots-inkeystone-com.id}"
  source_security_group_id = "${aws_security_group.nodes-labroots-inkeystone-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-labroots-inkeystone-com.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-labroots-inkeystone-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-labroots-inkeystone-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-labroots-inkeystone-com.id}"
  source_security_group_id = "${aws_security_group.nodes-labroots-inkeystone-com.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-labroots-inkeystone-com.id}"
  source_security_group_id = "${aws_security_group.nodes-labroots-inkeystone-com.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-labroots-inkeystone-com.id}"
  source_security_group_id = "${aws_security_group.nodes-labroots-inkeystone-com.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-labroots-inkeystone-com.id}"
  source_security_group_id = "${aws_security_group.nodes-labroots-inkeystone-com.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-labroots-inkeystone-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-labroots-inkeystone-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-east-2a-labroots-inkeystone-com" {
  vpc_id            = "vpc-0ef5e6a5916de5eac"
  cidr_block        = "10.10.32.0/19"
  availability_zone = "us-east-2a"

  tags = {
    KubernetesCluster                               = "labroots.inkeystone.com"
    Name                                            = "us-east-2a.labroots.inkeystone.com"
    SubnetType                                      = "Public"
    "kubernetes.io/cluster/labroots.inkeystone.com" = "owned"
    "kubernetes.io/role/elb"                        = "1"
  }
}

resource "aws_subnet" "us-east-2b-labroots-inkeystone-com" {
  vpc_id            = "vpc-0ef5e6a5916de5eac"
  cidr_block        = "10.10.64.0/19"
  availability_zone = "us-east-2b"

  tags = {
    KubernetesCluster                               = "labroots.inkeystone.com"
    Name                                            = "us-east-2b.labroots.inkeystone.com"
    SubnetType                                      = "Public"
    "kubernetes.io/cluster/labroots.inkeystone.com" = "owned"
    "kubernetes.io/role/elb"                        = "1"
  }
}

resource "aws_subnet" "us-east-2c-labroots-inkeystone-com" {
  vpc_id            = "vpc-0ef5e6a5916de5eac"
  cidr_block        = "10.10.96.0/19"
  availability_zone = "us-east-2c"

  tags = {
    KubernetesCluster                               = "labroots.inkeystone.com"
    Name                                            = "us-east-2c.labroots.inkeystone.com"
    SubnetType                                      = "Public"
    "kubernetes.io/cluster/labroots.inkeystone.com" = "owned"
    "kubernetes.io/role/elb"                        = "1"
  }
}

terraform = {
  required_version = ">= 0.9.3"
}
