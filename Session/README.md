# Session


## Email and password


```
POST /accounts/login

{
  "email": "user@example.com",
  "password": "password"
}
```

```
HTTP 200 OK

{
    "token": "<token>"
}
```


```
HTTP 401 OK
```
