New-AzResourceGroupDeployment `
    -ResourceGroupName 'bicep-fundamentals-3' `
    -Name main `
    -TemplateFile main.bicep `
    -environmentName Production