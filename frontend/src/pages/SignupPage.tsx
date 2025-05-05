import  { useState } from 'react';
import { TextField, Button, Typography, Container, Paper, Grid } from '@mui/material';
import { styled } from '@mui/system';
import { useAuth } from '../contexts/AuthContext';
import { useNavigate } from 'react-router-dom';

// Define styled components
  
  const Content = styled(Container)({
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center'
  })
  const PaperContainer = styled(Paper)({
    padding: '20px',
    margin:'0 auto',
    width: '100%',
    maxWidth: '400px',
    borderRadius: '8px',
    boxShadow: '0px 4px 30px rgba(0, 0, 0, 0.1)',
  });
  
  const Title = styled(Typography)({
    textAlign: 'center',
    marginBottom: '20px',
    color: '#2575fc',
  });
  
  const ErrorText = styled(Typography)({
    color: 'red',
    textAlign: 'center',
    marginBottom: '15px',
  });
  
  const FullWidthButton = styled(Button)({
    width: '100%',
    padding: '10px',
    background: '#2575fc',
    color: '#fff',
    '&:hover': {
      backgroundColor: '#6a11cb',
    },
  });
const SignupPage = () => {
    const {  register } = useAuth();
    const navigate = useNavigate();
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');

    const handleSignup = async (e: React.FormEvent) => {
        e.preventDefault()

        if (email === '' || password === '') {
          setError('email & password required');
          return;
        }

        try {
            await register(email, password);
            navigate('/login');
          } catch (err) {
            setError(`Signup failed due to ${err}`);
          }
      };

    return(
            <Content>
                <PaperContainer>
                    <Title variant="h5">Rewards app signup</Title>
                    {error && <ErrorText>{error}</ErrorText>}
        
                    <TextField
                    label="Email"
                    variant="outlined"
                    fullWidth
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    sx={{ marginBottom: 2 }}
                    />
        
                    <TextField
                    label="Password"
                    variant="outlined"
                    fullWidth
                    type="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    sx={{ marginBottom: 2 }}
                    />
        
                    <FullWidthButton
                    variant="contained"
                    onClick={handleSignup}
                    >
                        Sign up
                    </FullWidthButton>
        
                    <Grid container justifyContent="flex-end" style={{ marginTop: '10px' }}>
                        <div>
                            <Typography variant="body2" color="textSecondary">
                            Have an account? <a href="/login" style={{ color: '#2575fc' }}>Login</a>
                            </Typography>
                        </div>
                    </Grid>
                </PaperContainer>
            </Content>
    )
}

export default SignupPage