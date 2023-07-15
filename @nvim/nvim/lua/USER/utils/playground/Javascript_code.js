// This script will display the current time in the console.
import something from "./somewhere"

const time  new Date();
const hours = time.getHours();
const minutes = time.getMinutes();
const seconds = time.getSeconds();

console.log(`The current time is ${hours}:${minutes}:${seconds}`);
