const { MongoClient } = require('mongodb');

// Connection URI
const uri = 'mongodb://localhost:2717/otx_db';

async function main() {
    const client = new MongoClient(uri);

    try {
        await client.connect();

        const database = client.db('otx_db');
        const usersCollection = database.collection('users');

        const users = await usersCollection.find({}).toArray();
        console.log('Users:');
        console.log(users);

        const productsCollection = database.collection('products');
        const products = await productsCollection.find({}).toArray();
        console.log('Products:');
        console.log(products);


        const ordersCollection = database.collection('orders');
        const orders = await ordersCollection.find({}).toArray();
        console.log('Orders:');
        console.log(orders);
    } finally {
        await client.close();
    }
}

main().catch(console.error);
