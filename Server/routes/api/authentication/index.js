const router = require('express').Router();

const {comparePassword, hashPassword} = require('../../../modules/validate-password');
const pool = require('../../../modules/mysql-connection').pool;
const {createToken} = require('../../../modules/create-token');

router.post('/login', (request, response) => {

  const user = request.body;

  if (!user.username) {
    return response.status(401).json({errors: {username: "can't be blank"}});
  }

  if (!user.password) {
    return response.status(401).json({errors: {password: "can't be blank"}});
  }

  pool.getConnection((error, connection) => {

    if (error) {
      response.status(500).send({error: 'Server Error!'});
      return;
    }

    const query = 'SELECT U.UserName, U.Password, U.FirstName, U.LastName, U.Email, U.MobileNumber, R.RoleName FROM User U, Role R WHERE U.UserName = ? AND U.Role = R.RoleID';

    connection.query(query, [user.username], (error, results) => {
      if (error) {
        response.status(500).send({message: 'Server Error!'});
        return;
      }

      if (results.length === 0) {
        response.status(401).send({message: 'Username or password is incorrect!'});
        return;
      }

      const userData = JSON.parse(JSON.stringify(results[0]));

      comparePassword(user.password, userData.Password, (error, status) => {

        if (error) {
          response.status(500).send({message: 'Server Error!'});
          return;
        }

        if (status) {
          delete userData.Password;
          userData.Token = createToken(userData);
          response.status(200).send({
            message: 'Login Successful!',
            user: userData
          });
        } else {
          response.status(401).send({message: 'Username or password is incorrect!'})
        }

      });

    });

  });

});

module.exports = router;