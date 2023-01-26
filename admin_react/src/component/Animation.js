import React from 'react'
import { motion } from "framer-motion"

const animation = {
    initial: { opacity: 0, x: 100 },
    animate: { opacity: 1, x: 0 },
    exit: { opactiy: 0, x: -100 },
}

export default function Animation({children}) {
    return (
        <motion.div variants={animation} initial="initial" animate="animate">
                {children}
        </motion.div>
    )
}

