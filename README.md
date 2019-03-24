# Insights

To get necessary environment variables:

get a copy of .env from somewhere

```
. ./env.sh
```

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `cd assets && npm install`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: http://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Mailing list: http://groups.google.com/group/phoenix-talk
- Source: https://github.com/phoenixframework/phoenix

## Project Info

#### Models

_Issue_
Description: string
Identifier: string
Meetings: []
Discussions: []
Importance: float
Appropriations: integer
Votes: []
Status: string
urls: string

mix phx.gen.html Issues Issue issues description:string identifier:string importance:float appropriations:integer status:string urls:string

_Member_
Name: string
Description: string
Votes: []
Meetings: []

mix phx.gen.html Members Member members name:string description:string

_Discussion_
Present: string (comma seperated list)
Absent: string (comma seperated list)
Meeting: reference
Issue: reference

mix phx.gen.html Discussions Discussion discussions present:string absent:string meeting:references:meetings issue:references:issues

_Meeting_
Date: date
summary_url: string
minutes_url: string
Issues: []
Discussion: []
Body: string

mix phx.gen.html Meetings Meeting meetings date:date summary_url:string minutes_url:string body:string

_Vote_
member_id: reference
vote_type: integer ([-1, 0, 1])
Discussion: reference

mix phx.gen.html Votes Vote votes member_id:references:members vote_type:integer discussion:references:discussions

SECRET_KEY_BASE="\$(mix phx.gen.secret)" MIX_ENV=prod DATABASE_URL="ecto://postgres:postgres@localhost:5432/insights_dev" PORT=4000 mix phx.server
