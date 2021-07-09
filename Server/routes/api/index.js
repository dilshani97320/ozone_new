const router = require('express').Router();
const user = require('./users');
const attendance = require('./attendance');

router.use('/user', user);
router.use('/attendance', attendance);
router.use('/api',api);
router.use('/auth',auth);

router.use('/admin',admin);

router.use('/notification',notification);

router.use('/student',student);
router.use('/teacher',teacher);


module.exports = router;