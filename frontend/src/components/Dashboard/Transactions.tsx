import { Box, Tab, Tabs } from "@mui/material";
import React from "react";
import Rewards from "./Transactions/Rewards";
import Redemptions from "./Transactions/Redeemptions";

interface TabPanelProps {
    children?: React.ReactNode;
    index: number;
    value: number;
  }
const Transactions = ()=>{
    const [value, setValue] = React.useState(0);
    const CustomTabPanel = (props : TabPanelProps)=>{
        const {children, value, index} = props
        return (
            <div hidden={value !== index} id={`tabpanel-${index}`} style={{width: '640px'}}>
                {value === index && children}
            </div>
        )
    }
    const handleChange = (_event: React.SyntheticEvent, newValue: number) => {
        setValue(newValue);
      };

   return(
    <Box>
        <Tabs value={value} onChange={handleChange}>
            <Tab label="Rewards" id="dashboard-tab-0"/>
            <Tab label="Redemptions" id="dashboard-tab-1"/>
        </Tabs>
        <CustomTabPanel value={value} index={0}>
            <Rewards/>
        </CustomTabPanel>
      <CustomTabPanel value={value} index={1}>
            <Redemptions/>
        </CustomTabPanel>
    </Box>

    )
}

export default Transactions