local sceptre_user_data = std.parseJson(std.extVar('sceptre_user_data'));

{
  Outputs: {
    VpcId: {
      Description: 'New VPC ID',
      Value: {
        Ref: 'VirtualPrivateCloud',
      },
    },
  },
  Resources: {
    IGWAttachment: {
      Properties: {
        InternetGatewayId: {
          Ref: 'InternetGateway',
        },
        VpcId: {
          Ref: 'VirtualPrivateCloud',
        },
      },
      Type: 'AWS::EC2::VPCGatewayAttachment',
    },
    InternetGateway: {
      Type: 'AWS::EC2::InternetGateway',
    },
    VirtualPrivateCloud: {
      Properties: {
        CidrBlock: sceptre_user_data.cidr_block,
        EnableDnsHostnames: 'true',
        EnableDnsSupport: 'true',
        InstanceTenancy: 'default',
      },
      Type: 'AWS::EC2::VPC',
    },
  },
}
