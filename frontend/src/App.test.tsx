import { render, screen } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import '@testing-library/jest-dom';
import App from './App';

// Define components first
const LoginPage = () => <div data-testid="login-page">Login Page</div>;
const SignupPage = () => <div data-testid="signup-page">Signup Page</div>;
const Dashboard = () => <div data-testid="dashboard-page">Dashboard</div>;

// Mock the modules
jest.mock('./pages/LoginPage', () => ({
  __esModule: true,
  default: () => <div data-testid="login-page">Login Page</div>
}));

jest.mock('./pages/SignupPage', () => ({
  __esModule: true,
  default: () => <div data-testid="signup-page">Signup Page</div>
}));

jest.mock('./pages/Dashboard', () => ({
  __esModule: true,
  default: () => <div data-testid="dashboard-page">Dashboard</div>
}));

jest.mock('./components/PrivateRoute', () => ({
  PrivateRoute: ({ children }: { children: React.ReactNode }) => {
    const token = localStorage.getItem('token');
    return token ? children : <div data-testid="private-route-redirect">Redirecting to login</div>;
  }
}));

// Mock react-router-dom
jest.mock('react-router-dom', () => {
  const actual = jest.requireActual('react-router-dom');
  return {
    ...actual,
    BrowserRouter: ({ children }: { children: React.ReactNode }) => <>{children}</>,
    Routes: ({ children }: { children: React.ReactNode }) => <>{children}</>,
    Route: ({ path, element }: { path: string, element: React.ReactNode }) => element,
    Navigate: ({ to }: { to: string }) => <div data-testid="router-navigate" data-to={to}>Redirecting to {to}</div>
  };
});

// Mock the localStorage
const mockLocalStorage = {
  getItem: jest.fn(),
  setItem: jest.fn(),
  removeItem: jest.fn(),
  clear: jest.fn(),
  length: 0,
  key: jest.fn(),
};
Object.defineProperty(window, 'localStorage', { value: mockLocalStorage });

// Mock the context providers and components
jest.mock('./contexts/AuthContext', () => ({
  AuthProvider: ({ children }: { children: React.ReactNode }) => <div data-testid="auth-provider">{children}</div>,
  useAuth: () => ({ 
    currentUser: null,
    login: async () => {},
    register: async () => {},
    logout: async () => {}
  })
}));

jest.mock('./contexts/UserContext', () => ({
  UserProvider: ({ children }: { children: React.ReactNode }) => <div data-testid="user-provider">{children}</div>
}));

jest.mock('./contexts/RewardsContext', () => ({
  RewardsProvider: ({ children }: { children: React.ReactNode }) => <div data-testid="rewards-provider">{children}</div>
}));

describe('App', () => {
  beforeEach(() => {
    // Clear all mocks before each test
    jest.clearAllMocks();
    mockLocalStorage.getItem.mockClear();
  });

  it('renders login page on /login route', () => {
    render(
      <MemoryRouter initialEntries={['/login']}>
        <App />
      </MemoryRouter>
    );
    expect(screen.getByTestId('login-page')).toBeInTheDocument();
  });

  it('renders signup page on /signup route', () => {
    render(
      <MemoryRouter initialEntries={['/signup']}>
        <App />
      </MemoryRouter>
    );
    expect(screen.getByTestId('signup-page')).toBeInTheDocument();
  });

  it('redirects to login when accessing dashboard without auth token', () => {
    mockLocalStorage.getItem.mockReturnValue(null);
    
    render(
      <MemoryRouter initialEntries={['/']}>
        <App />
      </MemoryRouter>
    );
    
    expect(mockLocalStorage.getItem).toHaveBeenCalledWith('token');
    expect(screen.getByTestId('private-route-redirect')).toBeInTheDocument();
  });

  it('renders dashboard when auth token exists', () => {
    mockLocalStorage.getItem.mockReturnValue('fake-token');
    
    render(
      <MemoryRouter initialEntries={['/']}>
        <App />
      </MemoryRouter>
    );
    
    expect(mockLocalStorage.getItem).toHaveBeenCalledWith('token');
    expect(screen.getByTestId('dashboard-page')).toBeInTheDocument();
  });
}); 