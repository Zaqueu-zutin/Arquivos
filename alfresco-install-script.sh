
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "resources": [
    {
      "type": "Microsoft.Compute/virtualMachines",
      "apiVersion": "2021-07-01",
      "name": "myAlfrescoVM",
      "location": "[resourceGroup().location]",
      "properties": {
        "hardwareProfile": {
          "vmSize": "Standard_B1s"
        },
        "storageProfile": {
          "imageReference": {
            "publisher": "Canonical",
            "offer": "UbuntuServer",
            "sku": "18.04-LTS",
            "version": "latest"
          },
          "osDisk": {
            "createOption": "FromImage"
          }
        },
        "osProfile": {
          "computerName": "AlfrescoVM",
          "adminUsername": "admuser",
          "adminPassword": "!QAZ2wsx#EDC4rfv"
        },
        "networkProfile": {
          "networkInterfaces": [
            {
              "id": "[resourceId('Microsoft.Network/networkInterfaces', 'AlfrescoVMNic')]"
            }
          ]
        }
      }
    },
    {
      "type": "Microsoft.Compute/virtualMachines/extensions",
      "apiVersion": "2021-07-01",
      "name": "AlfrescoVM/installAlfresco",
      "location": "[resourceGroup().location]",
      "properties": {
        "publisher": "Microsoft.Azure.Extensions",
        "type": "CustomScript",
        "typeHandlerVersion": "2.0",
        "settings": {
          "fileUris": [
            "https://raw.githubusercontent.com/your-repo/alfresco-install-script.sh"
          ],
          "commandToExecute": "sh alfresco-install-script.sh"
        }
      }
    }
  ]
}
