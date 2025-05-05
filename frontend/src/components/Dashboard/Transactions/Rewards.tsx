import { Box, Button, Card, CardContent, Dialog, DialogActions, DialogContent, DialogTitle, Typography } from "@mui/material"
import { useRewards } from "../../../contexts/RewardsContext"
import Api from "../../../Api"
import { useState } from "react"
import { useUser } from "../../../contexts/UserContext"


const Rewards = ()=>{
   const { rewards, setRewards, setRedemptions } = useRewards()
   const { points, setPoints} = useUser()
   const [open, setOpen] = useState(false);
   const [selectedReward, setSelectedReward] = useState(null);

   const handleClose =() => {
    setOpen(false)
    setSelectedReward(null);
   }

   const handleOpen =(reward) => {
    setOpen(true)
    setSelectedReward(reward)
  }

   const handleRedemption = async (event) =>{
        
        if(!selectedReward)
        {
            return null
        }
        
        

        const button = event.target
        const rewardId = button.dataset.id

        const response = await Api.post('/redemptions', {'reward_id': rewardId})
        if(response)
        {
            const urls = ['/user_points', '/rewards', '/redemptions']
            const requests = urls.map(url => Api.get(url, {headers: {'Authorization': localStorage.getItem('token')}}));
            const responses = await Promise.all(requests);
            const results = responses.map(response => response.data)
            if(results)
            {
                const user_points = results[0].data.points
                const rewards = results[1].data
                const redemptions = results[2].data
        
                setPoints(user_points)
                setRewards(rewards)
                setRedemptions(redemptions) 
                setOpen(false)
                setSelectedReward(null);
            }
        }
            

   }


   
   return(
    <Box overflow={"scroll"} height={'400px'} paddingTop={'10px'} paddingBottom={'10px'} paddingLeft={'5px'} paddingRight={'5px'} sx={{backgroundColor: 'lightgray'}}>
    {rewards.map((reward) =>(
        <Card key={reward.id} variant="elevation" style={{marginTop: '10px'}}>
            <CardContent>
                <h2>{reward.title}</h2>
                <div style={{display: 'flex', flexDirection: 'row', width: 'inherit', justifyContent:'space-between'}}>
                    <Typography color="success">{`${reward.points} pts`}</Typography>
                    {points >= reward.points ? 
                        (<Button variant="contained" onClick={()=>{handleOpen(reward)}}>Redeem</Button>) : 
                        (<Button variant="contained"  disabled>Not enough points</Button>)
                    }
                </div>
            </CardContent>
        </Card>     
    ))}
    {selectedReward && (
        <Dialog open={open}>
            <DialogTitle>
                Are you sure you want to redeem ?
            </DialogTitle>
            <DialogContent>
                You are about to redeem {selectedReward.points} for {selectedReward.title} 
            </DialogContent>
            <DialogActions>
                <Button variant="contained"  data-id={selectedReward.id} onClick={handleRedemption} autoFocus>Continue</Button>
                <Button onClick={handleClose}> Cancel </Button>
            </DialogActions>
        </Dialog>
    )}
    </Box>
    )
}

export default Rewards