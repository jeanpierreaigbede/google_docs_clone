const express = require("express");
const User = require("../models/user");

const jwt = require('jsonwebtoken');
const auth = require("../midleweares/auth");

const authRouter  = express.Router();



authRouter.post('/api/signup/',async (req,res)=>{


   try {
    
    const { name ,email , profilePic} = req.body;

    // email already exist ?
    let user = await User.findOne({email:email});

    if(!user){

      user = new User({
         name:name,
         email:email,
         profilePic : profilePic
      });

      user = await user.save();
    }

    token = jwt.sign({id:user._id});
    res.json({user,token});

   } catch (e) {
    res.status(500).json({error : e.messsage});
   }


});


authRouter.get("/",auth,async(req,res)=>{

   const user = await User.findById(req.user);
   res.json({user,token:req.token});
});


module.exports = authRouter;


