from agno.agent import Agent
from agno.models.groq import Groq
from dotenv import load_dotenv
from agno.tools.duckduckgo import DuckDuckGoTools
from agno.team import Team
import os

load_dotenv()
api_key = os.getenv("API_KEY_GROQ")

eng_agent = Agent(name = "English Agent", role = "you answer question in english")
chi_agent = Agent(name = "Chinese Agent", role = "You answer question in chinese")
hindi_agent = Agent(name = "Hindi Agent", role = "You answer question in Hindi")

team_leader = Team(
    name = "Answer & translation team",
    members = [eng_agent, chi_agent, hindi_agent],
    model = Groq(id = "qwen/qwen3.6-27b", api_key=api_key, max_tokens = 800),
    markdown = True,
    show_members_responses=True,
    instructions = """ All member agents must respond to answer the query in their specific language. 
                        Do not route to just one agent.
                        Output the response of all agents.
                        You answer in all 3 language strictly follow this.
                """
)

team_leader.print_response("भारत की राजधानी कहाँ स्थित है?")