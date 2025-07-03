New-AzResourceGroupDeployment `
    -ResourceGroupName 'bicep-fundamentals-2' `
    -Name main `
    -TemplateFile main.bicep `
    -TemplateParameterFile main.parameters.json `
    -environmentName dev