---
layout: post
title:  "Mocking a `httpClientProvider` in Node.js"
---

When developing web applications or APIs, it's common to use a HTTP client to make requests to external services or APIs. In Node.js, one popular library for making HTTP requests is `axios`. However, when writing tests for your application, you may want to mock the HTTP client to simulate different responses or test different scenarios.

In this article, we'll explore how to mock a `httpClientProvider` in Node.js using the jest testing framework and the `axios-mock-adapter` library.

### What is a `httpClientProvider`?
A `httpClientProvider` is a service that provides an interface for making HTTP requests. In Node.js, axios is a popular choice for making HTTP requests, as it provides an easy-to-use API and supports features like request and response interceptors, automatic content-type detection, and more.

However, when writing tests for your application, you may want to mock the `httpClientProvider` to simulate different responses or test different scenarios. This can help you test your application's behavior in different edge cases or error scenarios.

### Mocking a `httpClientProvider` with jest and `axios-mock-adapter`
To mock a `httpClientProvider` in Node.js, we'll use the `axios-mock-adapter` library. This library provides a simple way to intercept and mock HTTP requests made using the axios library.

Here's an example of how to use `axios-mock-adapter` to mock a `httpClientProvider` in a Node.js application:

```js
const axios = require('axios');
const MockAdapter = require('axios-mock-adapter');

// create a new instance of the axios-mock-adapter
const mock = new MockAdapter(axios);

// mock a GET request to /users
mock.onGet('/users').reply(200, {
  users: [{ id: 1, name: 'John' }, { id: 2, name: 'Jane' }],
});

// make a request to /users
axios.get('/users').then((response) => {
  console.log(response.data); // { users: [{ id: 1, name: 'John' }, { id: 2, name: 'Jane' }] }
});
```

In this example, we create a new instance of the `axios-mock-adapter` and use the onGet method to mock a GET request to the `/users` endpoint. We specify a response code of 200 and a response body containing an array of user objects.

Then, we use the axios library to make a GET request to the `/users` endpoint. Because we've mocked this endpoint using axios-mock-adapter, the response we receive will match the mock data we specified.

Conclusion
Mocking a `httpClientProvider` in Node.js is a useful technique for testing your application's behavior in different edge cases or error scenarios. By using the `axios-mock-adapter` library with the `jest` testing framework, you can easily mock HTTP requests and test your application's behavior without relying on external services or APIs.