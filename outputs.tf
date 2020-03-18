/*
 * Copyright (c) 2019 Qumulo, Inc. All rights reserved.
 *
 * NOTICE: All information and intellectual property contained herein is the
 * confidential property of Qumulo, Inc. Reproduction or dissemination of the
 * information or intellectual property contained herein is strictly forbidden,
 * unless separate prior written permission has been obtained from Qumulo, Inc.
 */

output "instance_ids" {
  value       = local.all_nodes.*.id
  description = "EC2 Instance IDs for all nodes in the cluster"
}

output "private_ips" {
  value       = local.all_nodes.*.private_ip
  description = "EC2 instance private IPs"
}

output "public_ips" {
  value       = local.all_nodes.*.public_ip
  description = "EC2 instance public IPs (if set)"
}
