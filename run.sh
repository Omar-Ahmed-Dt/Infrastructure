cd terraform
terraform init
terraform apply

if [ $? -ne 0 ]
then
    echo "Error During Terraform Execution, Failed Run!"
    exit $?
fi

cd ..

bastion_host_ip=$(awk -F= '{if($1=="bastion_host_ip") {print $2;exit}}' outputs.txt)
cluster_name=$(awk -F= '{if($1=="cluster_name") {print $2;exit}}' outputs.txt)

if [[ ! $bastion_host_ip || ! $cluster_name ]]
then
    echo "Empty Variables, Failed Run!"
    exit 1
fi

cat > ansible/inventory <<EOF
[bastion]
$bastion_host_ip
EOF

echo "The inventory has been updated!"

workernodes_asg=$(aws eks describe-nodegroup \
--cluster-name private_eks \
--nodegroup-name private_eks_ng \
--query 'nodegroup.resources.autoScalingGroups[]' \
--output text)

instance_id=$(aws autoscaling describe-auto-scaling-groups \
--auto-scaling-group-names $workernodes_asg \
--query 'AutoScalingGroups[].Instances[0].InstanceId' \
--output text)

instance_host_name=$(aws ec2 describe-instances \
--instance-ids $instance_id \
--query 'Reservations[].Instances[].PrivateDnsName' \
--output text)

echo "Starting Playbook Now..."

ansible-playbook ansible/playbook.yml -e "cluster_name=${cluster_name}" -e "workernode_hostname=${instance_host_name}" --ask-vault-pass

