# HelloID-Task-SA-Target-<System>-<Description of action>
###########################################################
# Form mapping
$formObject = @{
    userName           = $form.userName
    firstName          = $form.firstName
    lastName           = $form.lastName
    contactEmail       = $form.contactEmail
    isEnabled          = [bool]$form.isEnabled
    password           = $form.password
    mustChangePassword = [bool]$form.mustChangePassword
}

try {
    Write-Information "Executing <System> action: [CreateAccount] for: [$($formObject.userName)]"
    Write-Verbose "Creating authorization headers"
    # Create authorization headers with <System> API key
    $pair = "${portalApiKey}:${portalApiSecret}"
    $bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
    $base64 = [System.Convert]::ToBase64String($bytes)
    $key = "Basic $base64"
    $headers = @{"authorization" = $Key }

    Write-Verbose "Creating <System>Account for: [$($formObject.userName)]"
    $splatCreateUserParams = @{
        Uri         = "$($portalBaseUrl)/api/v1/users"
        Method      = "POST"
        Body        = ([System.Text.Encoding]::UTF8.GetBytes(($formObject | ConvertTo-Json -Depth 10)))
        Verbose     = $false
        Headers     = $headers
        ContentType = "application/json"
    }
    $response = Invoke-RestMethod @splatCreateUserParams

    $auditLog = @{
        Action            = "CreateAccount"
        System            = "<System>"
        TargetIdentifier  = [String]$response.userGUID
        TargetDisplayName = [String]$response.userName
        Message           = "<System> action: [CreateAccount] for: [$($formObject.userName)] executed successfully"
        IsError           = $false
    }
    Write-Information -Tags "Audit" -MessageData $auditLog

    Write-Information "<System> action: [CreateAccount] for: [$($formObject.userName)] executed successfully"
}
catch {
    $ex = $_
    $auditLog = @{
        Action            = "CreateAccount"
        System            = "<System>"
        TargetIdentifier  = ""
        TargetDisplayName = [String]$formObject.userName
        Message           = "Could not execute <System> action: [CreateAccount] for: [$($formObject.userName)], error: $($ex.Exception.Message)"
        IsError           = $true
    }
    if ($($ex.Exception.GetType().FullName -eq "Microsoft.PowerShell.Commands.HttpResponseException")) {
        $auditLog.Message = "Could not execute <System> action: [CreateAccount] for: [$($formObject.userName)]"
        Write-Error "Could not execute <System> action: [CreateAccount] for: [$($formObject.userName)], error: $($ex.ErrorDetails)"
    }
    Write-Information -Tags "Audit" -MessageData $auditLog
    Write-Error "Could not execute <System> action: [CreateAccount] for: [$($formObject.userName)], error: $($ex.Exception.Message)"
}
###########################################################