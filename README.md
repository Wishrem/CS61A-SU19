# CS61A-SICP
Berkeley CS 61A SICP Summer19 course's homework, labs and projects.

# About OK  
## Prepare Environment
I use Anaconda to create a environment named 'ok' and my platform is **MacOS**. 
The version of Python is 3.9.16. I have pushed my package list 'requirements.txt', when you've downloaded the file, you should get in the folder which contains 'requirements.txt', then run this command `conda create --name ok --file requirement.txt` to create an environment named 'ok' and install all packages in 'requirements.txt'.  
## Update OK
You need run the below command in every time you downloaded a new 'lab', 'project' or 'homework'.  
```bash
conda activate ok # activate the env
python ok # update OK
```
After doing that, it'll raise an KeyError 'BREAK_LOOP'. Don't worry about that, that means you have successfully update OK.  
## Attention
**DON'T USE `python3` TO RUN ANYTHING!** Use `python ok` or `python scheme`.  
USE `--local` FLAG IN THE TAIL OF COMMAND.
