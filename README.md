# HelloID-Task-SA-Target-HelloID-UserGrantMembership

## Prerequisites
- [ ] HelloID API key and secret
- [ ] Pre-defined variables: `portalBaseUrl`, `portalApiKey` and `portalApiSecret` created in your HelloID portal.

## Description
This code snippet will add an existing user to a group within HelloID and executes the following tasks:

1. Define a hash table `$formObject`. The keys of the hash table represent the properties necessary to add an existing user to a group within `HelloID`, while the values represent the values entered in the form.

> To view an example of the form output, please refer to the JSON code pasted below.

```json
{
    "userGUID": "00f793c8-32ae-4f19-8e33-3ac1f0858a98",
    "userName": "john.doe",
    "groupGUID": "9509133d-8ae4-48bf-a2cb-e0f31cae4deb",
    "groupName": "John Doe's group"
}
```

> :exclamation: It is important to note that the names of your form fields might differ. Ensure that the `$formObject` hash table is appropriately adjusted to match your form fields.
> [See the HelloID API Docs page](https://apidocs.helloid.com/docs/helloid/575c5cde6e378-link-a-user-to-a-group)

2. Creates authorization headers using the provided API key and secret.

3. Add an existing user to a group using the: `Invoke-RestMethod` cmdlet. The hash table called: `$formObject` is passed to the body of the: `Invoke-RestMethod` cmdlet as a JSON object.
