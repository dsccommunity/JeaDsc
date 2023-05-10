@{
    PSDependOptions             = @{
        AddToPath  = $true
        Target     = 'output\RequiredModules'
        Parameters = @{
            Repository = 'PSGallery'
        }
    }

    InvokeBuild                 = 'latest'
    PSScriptAnalyzer            = 'latest'
    Pester                      = '4.10.1'
    Plaster                     = 'latest'
    ModuleBuilder               = 'latest'
    ChangelogManagement         = 'latest'
    Sampler                     = 'latest'
    'Sampler.GitHubTasks'       = 'latest'
    MarkdownLinkCheck           = 'latest'
    'DscResource.Common'        = 'latest'
    'DscResource.Test'          = 'latest'
    'DscResource.AnalyzerRules' = 'latest'
    xDscResourceDesigner        = 'latest'
    'DscResource.DocGenerator'  = 'latest'

    ConvertToExpression         = @{
        DependencyType = 'FileDownload'
        Source         = 'https://raw.githubusercontent.com/iRon7/ConvertTo-Expression/93cd563fb9a1dd5b6fc9c73d6f3b95f6f2ebeca8/ConvertTo-Expression.ps1'
        Target         = 'source\Modules\ConvertToExpression\ConvertToExpression.psm1'
    }
}
