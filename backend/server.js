const bcrypt = require('bcrypt');
const SALT_ROUNDS = 10;

const admin = require('firebase-admin');
const serviceAccount = require('./firebase-key.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://openday-db-default-rtdb.firebaseio.com/"  
});

const db = admin.database();

const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.send('Hello NetMakers Team!');
});

const { getAuth } = require('firebase-admin/auth');

app.post('/signup', async (req, res) => {
  const { username, email,  password, confirmPassword } = req.body;

  console.log('Received signup request:', req.body);

  if (password !== confirmPassword) {
    return res.status(400).send({ message: 'Passwords do not match' });
  }

  try {
    const userRef = db.ref('users/' + username);
    const snapshot = await userRef.once('value');

    if (snapshot.exists()) {
      console.log('User already exists');
      return res.status(400).send({ message: 'User already exists' });
    }

    const userRecord = await getAuth().createUser({
      email: email,
      password: password,
    });

    const hashedPassword = await bcrypt.hash(password, SALT_ROUNDS);

    await userRef.set({
      uid: userRecord.uid,
      username,
      email,
      password: hashedPassword 
    });

    console.log('User created successfully');
    res.send({ message: 'Signup successful' });

  } catch (error) {
    console.error('Signup error:', error);
    res.status(500).send({ message: 'Signup failed' });
  }
});

app.post('/signin', async (req, res) => {
  const { username, password } = req.body;

  try {
    const userRef = db.ref('users/' + username);
    const snapshot = await userRef.once('value');

    if (!snapshot.exists()) {
      return res.status(404).send({ message: 'User not found' });
    }

    const user = snapshot.val();

    const isPasswordValid = await bcrypt.compare(password, user.password);

    if (isPasswordValid) {
      res.send({ message: 'Signin successful' });
    } else {
      res.status(401).send({ message: 'Wrong password' });
    }

  } catch (error) {
    console.error('Signin error:', error);
    res.status(500).send({ message: 'Login failed' });
  }
});

app.post('/track-scan', async (req, res) => {
  const { username, qrId } = req.body;

  if (!username || !qrId) {
    return res.status(400).send({ message: 'Missing username or QR ID' });
  }

  try {
    const scanRef = db.ref(`qr_scans/${qrId}/${username}`);
    const snapshot = await scanRef.once('value');

    if (snapshot.exists()) {
      return res.status(200).send({ message: 'User already scanned this QR code' });
    }

    await scanRef.set(true);
    return res.send({ message: 'QR scan recorded successfully' });

  } catch (error) {
    console.error('QR scan tracking error:', error);
    return res.status(500).send({ message: 'Failed to track scan' });
  }
});

app.post('/reset-password', async (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).send({ message: 'Email is required' });
  }

  try {
    const link = await admin.auth().generatePasswordResetLink(email);
    // Optionally send using custom email service — or rely on Firebase default email

    res.send({ message: 'Reset link sent', link }); // You can remove the link in production
  } catch (error) {
    console.error('Reset password error:', error);
    res.status(500).send({ message: 'Failed to send reset link' });
  }
});


app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});