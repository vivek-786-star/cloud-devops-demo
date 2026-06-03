def calculate_score(skills):

    # preferred_skills = {
    #     "python",
    #     "aws",
    #     "docker",
    #     "terraform",
    #     "fastapi",
    #     "kubernetes",
    #     "git"
    # }
    
    preferred_skills = {
    "python": 20,
    "aws": 20,
    "docker": 15,
    "terraform": 15,
    "kubernetes": 15,
    "fastapi": 10,
    "github actions": 5
    }

    # matched = len(
    #     set(skill.lower() for skill in skills)
    #     & preferred_skills
    # )

    # score = (matched / len(preferred_skills)) * 100
    
    score = 0

    for skill in skills:
        skill = skill.lower()

        if skill in preferred_skills:
            score += preferred_skills[skill]

    if score >= 70:
        recommendation = "Strong Match"
    elif score >= 40:
        recommendation = "Potential Match"
    else:
        recommendation = "Weak Match"

    return round(score), recommendation