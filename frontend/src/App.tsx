import {BrowserRouter as Router, Routes, Route} from 'react-router-dom'
import './App.css'
import { AuthProvider } from './contexts/AuthContext'
import LoginPage from './pages/LoginPage'
import Dashboard from './pages/Dashboard'
import { PrivateRoute } from './components/PrivateRoute'
import SignupPage from './pages/SignupPage'
import { UserProvider } from './contexts/UserContext'
import { RewardsProvider } from './contexts/RewardsContext'

function App() {

  return (
    <AuthProvider>
      <UserProvider>
        <RewardsProvider>
          <Router>
            <Routes>
              <Route path='/login' element={<LoginPage />} />
              <Route path='/signup' element={<SignupPage />} />
              <Route path= '/' element={
                <PrivateRoute>
                  <Dashboard/>
                </PrivateRoute>
              }/>
            </Routes>
          </Router>
        </RewardsProvider>
      </UserProvider>
    </AuthProvider>
  )
}

export default App
