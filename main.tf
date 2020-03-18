/*
 * Copyright (c) 2019 Qumulo, Inc. All rights reserved.
 *
 * NOTICE: All information and intellectual property contained herein is the
 * confidential property of Qumulo, Inc. Reproduction or dissemination of the
 * information or intellectual property contained herein is strictly forbidden,
 * unless separate prior written permission has been obtained from Qumulo, Inc.
 */

resource "aws_instance" "leader_node" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  tags                   = merge({ Name = "${var.cluster_name} 1" }, var.tags)

  # This user_data will be used to instruct the leader_node to form a cluster
  # with the other nodes.
  user_data = jsonencode({
    node_ips     = aws_instance.node.*.private_ip
    cluster_name = var.cluster_name
  })
}

resource "aws_instance" "node" {
  count = var.node_count - 1

  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  tags                   = merge({ Name = "${var.cluster_name} ${count.index + 1}" }, var.tags)
}
