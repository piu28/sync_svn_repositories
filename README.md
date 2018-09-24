# sync_svn_repositories
This bash script can sync branches of two SVN Repositories excluding some particular files for example Jenkinsfile, .svn and some other files. The workflow and usage of the script are given below. Here, we have same branch name for both the SVN Repositories. Ensure to update the variables(Repo URLs, Username, Password etc) with your credentials in the script before executing it. 

## Workflow:
- Clone branches of both the repositories REPO01 and REPO02 in the WORKDIR.
- Execute RSYNC command to copy the files from the source repo to the target repo. The exclude argument has been used to exclude particular files.
- Use svn commands to push the changes to the target Repo.
- Schedule the command using Crontab.

## Usage:
While executing the script, give the branch name as argument.
./sync_svn_repo.sh <SVN_BRANCH>

## Crontab:
Following pattern can be used to schedule the bash script in crontab. In our case, we had to sync 4 to 5 SVN branches. Hence, we have scheduled multiple commands in the crontab.
0 1 * * * sh /home/ec2-user/sync_svn_repo.sh branch01 >> /var/log/cron_svnsync/branch01/`date +\%Y\%m\%d-\%H\%M\%S`-cron.log 2>&1
0 2 * * * sh /home/ec2-user/sync_svn_repo.sh branch02 >> /var/log/cron_svnsync/branch02/`date +\%Y\%m\%d-\%H\%M\%S`-cron.log 2>&1 
0 3 * * * sh /home/ec2-user/sync_svn_repo.sh branch03 >> /var/log/cron_svnsync/branch03/`date +\%Y\%m\%d-\%H\%M\%S`-cron.log 2>&1
