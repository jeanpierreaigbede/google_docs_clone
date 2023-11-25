
const express = require('express')
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');
const cors = require('cors');

const  app = express();

app.use(express.json());
app.use(cors());
app.use(authRouter);

const DB ='mongodb+srv://aigbedesemansoujeanpierre:5LOLVRRnbUoJdQYE@cluster0.qlrxvyi.mongodb.net/';

mongoose.connect(DB).then(()=>{
    console.log('Connexted sucessfully');
}).catch((err)=>{
    console.log(err);
});

const PORT = process.env.PORT | 3001;

 app.listen(PORT,"0.0.0.0",()=>{
 console.log("Connected on 3001");
 console.log("This changing efghj");
 })