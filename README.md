## NFLX-security-monkey

#### What's the Monkey that cares about security?
Security Monkey monitors policy changes and alerts on insecure configurations in an AWS account. 
While Security Monkey’s main purpose is security, it also proves a useful tool for tracking down potential problems as it is essentially a change tracking system.

#### So, what this docker container does?
This is a repository with Dockerfile and bootstrap scripts to get the Netflix' Security Monkey up.
Still, you'll need to prepare you AWS environment to be able to use it.

The source for this Dockerfile is located here: ```http://securitymonkey.readthedocs.org/en/latest/quickstart.html```

#### How do I get it running?

1. git clone https://github.com/jpazdyga/NFLX-security-monkey/
2. python NFLX-security-monkey/aws/create_roles.py
Write down the credentials displayed
3. sudo docker pull jpazdyga/nflx-security-monkey
4. sudo docker run -d -p 443:443 --name secmonkey --env AWS_ACCESS_KEY=AKI4CTVTTGZBAXJ55A --env AWS_SECRET_ACCESS_KEY=kNE0vmcEOswtpp537PvUoXEmsn1V7JXLoluuGdUe jpazdyga/nflx-security-monkey
5. sudo docker exec -ti secmonkey /usr/sbin/botocfg.sh
6. sudo docker exec secmonkey /usr/sbin/sm_api_server.sh &
Visit https://127.0.0.1 to see you Security Monkey running. Set up the new account. Please be aware, that after creating the new account, nginx/app redirects to “`http://127.0.0.1/None“` (not https://). That needs to be fixed.
Log in and click “Settings”
Click the “+” on the right, to add new IAM account to be investigated
Fill the details you know in the form and mark “Active” radio. Click “Save”
7. Run: sudo docker exec secmonkey /usr/sbin/sm_scheduler.sh &
Wait for the results to be displayed.

