# SAVER

This app exposes an API that allows you to index and retrieve a webpage.

## General
* Each request content-type must be sent as `application/json`, otherwise the API will return a `401` response.
* Each response is formatted as standard JSON


## Endpoints

### Get the pages and their contents
```
GET
/api/v1/pages
```
You can also do paginate the results by providing the page[number] and page[size] parameters.
```
GET
/api/v1/pages?page[number]=1&page[size]=50
```
By default the API will return 30 items per page.

### Index a page contents

#### Parameters
* **url**: (Required | String), The url of the page you want to index.
* **tags**: (Not required | Array), The list of the names of the html tags you want the API to store from the page. The tags names you provided must be among of the following:
  * h1
  * h2
  * h3
  * a

```
POST
/api/v1/pages
```
```
PARAMETERS
{
  "page": {
    "url": "your_page_url",
    "tags" ["h1", "h2"]
  }
}
```

## Future improvements

### Authentication
We plan to add basic authentication with an API key for performing requests.

### Throttling
We also plan to add some throttling using [rack-attack](https://github.com/kickstarter/rack-attack) gem.
