import { Box, Button, Drawer, List, ListItem, ListItemButton, ListItemIcon, ListItemText, styled, Typography } from "@mui/material"
import { useUser } from "../contexts/UserContext"
import { useState } from "react"
import PersonIcon from '@mui/icons-material/Person';
import ExitToAppIcon from '@mui/icons-material/ExitToApp';
import { useAuth } from "../contexts/AuthContext";
import { useNavigate } from "react-router-dom";
import MenuIcon from '@mui/icons-material/Menu';
const Header = ()=>{
   const { email } = useUser()
   const [open, setOpen] = useState(false)

   const toggleDrawer = () => {
    if (document.activeElement instanceof HTMLElement) {
        document.activeElement.blur();
      }
    setOpen((prevValue)=>!prevValue)
   }

   const { logout } = useAuth()
   const navigate = useNavigate();
   const [error, setError] = useState('');


   const ErrorText = styled(Typography)({
    color: 'red',
    textAlign: 'center',
    marginBottom: '15px',
  });

  const MenuButton = styled(Button)({
    display: 'flex',
    alignSelf:'flex-end'
  });


   const handleLogout = async (e: React.FormEvent) => {

    try {
        await logout()
        setOpen(false)
        navigate('/login')
      } catch (err) {
        setError('Unable to logout! Please try again.');
      }
  }; 
   const DrawerList = (
        <Box sx={{ width: 350 }} role="presentation">
            <List>
                <ListItem key={email} disablePadding>
                    <ListItemButton>
                        <ListItemIcon>
                                    <PersonIcon/>
                        </ListItemIcon>
                        <ListItemText primary={email} />
                    </ListItemButton>
                        
            </ListItem>
            <ListItem key={'logout'} disablePadding>
                    <ListItemButton onClick={handleLogout}>
                        <ListItemIcon>
                            <ExitToAppIcon/>
                        </ListItemIcon>
                    <ListItemText primary="Logout" />
                    {error && <ErrorText>{error}</ErrorText>}
                </ListItemButton>
            </ListItem>
            </List>
        </Box>
    )
   return(
    <header style={{display: 'flex', width: 'inherit'}}>
        <nav>
            <MenuButton onClick={toggleDrawer}>
                <MenuIcon/>
            </MenuButton>
            <Drawer open={open} onClose={toggleDrawer} variant="temporary">
                {DrawerList}
            </Drawer>   
        </nav>      
    </header>
    )
}

export default Header