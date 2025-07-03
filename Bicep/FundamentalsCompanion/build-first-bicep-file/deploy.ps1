New-AzResourceGroupDeployment `
    -ResourceGroupName 'bicep-fundamentals' `    
    -Name main `
    -TemplateFile main.bicep `
    -environmentType nonprod