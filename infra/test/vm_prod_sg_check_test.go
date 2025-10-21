package terratest

import (
	"context"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
	ycvpc "github.com/yandex-cloud/go-genproto/yandex/cloud/vpc/v1"
	ycsdk "github.com/yandex-cloud/go-sdk"
)

func TestSecurityGroup(t *testing.T) {

	// Инициализация Yandex Cloud SDK для проверки существования ВМ
	ctx := context.Background()
	yc, err := ycsdk.Build(ctx, ycsdk.Config{
		Credentials: getYCToken(t), // Функция для получения токена
	})
	if err != nil {
		t.Fatalf("Failed to initialize Yandex Cloud SDK: %v", err)
	}

	if err != nil {
		t.Fatalf("Failed to get list of VPC")
	}

	sgName := "prod-sec-group"

	secGroups, err := yc.VPC().SecurityGroup().List(ctx, &ycvpc.ListSecurityGroupsRequest{
		FolderId: "b1g82d74ovgmnan1vate",
	})

	if err != nil {
		t.Fatalf("Failed to list Sec Groups: %v", err)
	}

	sshPortOpen := false
	httpPortOpen := false
	egressOpen := false

	for _, secGroup := range secGroups.SecurityGroups {
		if strings.Compare(sgName, secGroup.Name) == 0 {
			for _, rule := range secGroup.Rules {
				if rule.Direction == 1 {
					if rule.Ports.ToPort == 22 && strings.Compare(rule.ProtocolName, "TCP") == 0 {
						sshPortOpen = true
					} else if rule.Ports.ToPort == 8200 && strings.Compare(rule.ProtocolName, "TCP") == 0 {
						httpPortOpen = true
					}
				} else if rule.Direction == 2 {
					if rule.Ports == nil && strings.Compare(rule.ProtocolName, "ANY") == 0 {
						egressOpen = true
					}
				}
			}
		}
	}

	assert.True(t, sshPortOpen, "SSH Port Must Be Open")
	assert.True(t, httpPortOpen, "HTTP Port Must Be Open")
	assert.True(t, egressOpen, "Egress trafic Must Be Free")
}
