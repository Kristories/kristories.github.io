---
layout: post
title:  "MongoDB Capped Collections"
---

MongoDB is a widely used NoSQL database that is known for its flexibility and scalability. One of the features that sets MongoDB apart from traditional SQL databases is its support for capped collections. In this article, we'll explore what [capped collections](https://www.mongodb.com/docs/manual/core/capped-collections) are and how they can be used in MongoDB.

### What are Capped Collections?
A capped collection is a fixed-size collection in MongoDB that maintains insertion order. Capped collections are essentially circular buffers that automatically overwrite older data when they reach their maximum size. This makes them ideal for storing log data or other time-series data where the older data is less valuable than the more recent data.

Capped collections have a fixed size, which means that they cannot be resized once they have been created. This also means that once a capped collection has reached its maximum size, new documents can only be added by overwriting older documents.

### Creating a Capped Collection
To create a capped collection in MongoDB, you can use the `db.createCollection()` method with the `capped` option set to `true`. You'll also need to specify the maximum size of the collection in bytes using the `size` option.

Here's an example of creating a capped collection with a maximum size of 100 megabytes:

```
db.createCollection(
    "myCappedCollection", 
    { 
        capped: true, 
        size: 100000000 
    }
)
```

Once you've created a capped collection, you can insert documents into it just like you would with a regular collection. However, when the collection reaches its maximum size, older documents will be automatically overwritten.

### Querying a Capped Collection
Querying a capped collection in MongoDB is similar to querying a regular collection. However, there are some limitations to keep in mind. For example, you can only query a capped collection in insertion order, and you cannot sort the results of a query.

Here's an example of querying a capped collection in MongoDB:

```
db.myCappedCollection.find()
    .limit(10)
    .forEach(printjson)
```

This query will return the first 10 documents in the `myCappedCollection` collection, in the order that they were inserted.

### Conclusion
Capped collections are a powerful feature in MongoDB that can be used to store time-series data or other data that has a limited lifespan. They are easy to create and use, and can be an effective way to manage large volumes of data in MongoDB. By understanding how capped collections work, you can take advantage of this feature to build more efficient and scalable MongoDB applications.