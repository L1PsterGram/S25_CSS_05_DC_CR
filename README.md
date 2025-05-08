# S25_CSS_05_DC_CR

# Vulnerability Scanning & Reporting Tool

## Table of Contents

- [Overview](#overview)
- [Scope: Vulnerability Scanning & Reporting Tool](#scope-vulnerability-scanning--reporting-tool)
  - [Systems & Applications Targeted for Scanning](#systems--applications-targeted-for-scanning)
  - [Core Components & Functionalities of the Developed Tool](#core-components--functionalities-of-the-developed-tool)
  - [Security Domain & Vulnerabilities Covered](#security-domain--vulnerabilities-covered)
  - [Explicitly Out of Scope for this Project](#explicitly-out-of-scope-for-this-project)
- [Deliverables](#deliverables)
- [Repository Structure](#repository-structure)
- [Setup & Installation](#setup--installation)
  - [1. Prerequisites](#1-prerequisites)
  - [2. Installation Steps](#2-installation-steps)
  - [3. Usage](#3-usage)
- [Contribution Guidelines](#contribution-guidelines)
- [Testing & Validation](#testing--validation)
  - [1. Automated Testing](#1-automated-testing)
  - [2. Manual Testing](#2-manual-testing)
- [License](#license)
- [Additional Notes](#additional-notes)
  - [Project-Specific Considerations](#project-specific-considerations)
  - [Future Enhancements](#future-enhancements)
  - [Known Issues & Limitations (as of May 2025)](#known-issues--limitations-as-of-may-2025)

## Overview

The "Vulnerability Scanning & Reporting Tool" is a software project developed by Daniel Critchlow Jr. and Carlos Rodriguez for the Computer Systems Security course in Spring 2025.

**Objective:**
The primary objective of this project is to enhance organizational cybersecurity defenses, with a particular focus on web applications. This is achieved by developing an advanced tool designed to automate the identification of potential security weaknesses. The tool aims to provide detailed, actionable reports that assist developers and security professionals in effectively understanding, prioritizing, and mitigating these vulnerabilities.

**Background:**
Web applications are integral to modern business operations but are frequently targeted due to security vulnerabilities. Exploitation of these weaknesses by malicious actors can lead to significant data breaches, financial loss, and reputational damage. Therefore, regular and thorough vulnerability scanning is crucial for identifying and addressing these security gaps proactively. This tool aims to provide a streamlined solution for this critical process.

**Key Functionalities:**

The tool is designed with a modular architecture and includes the following core functionalities:

1.  **Automated Vulnerability Scanning:**
    * A custom-built scanning engine to probe target web applications for a range of known security vulnerabilities (e.g., those listed in the OWASP Top 10, common misconfigurations).
    * Integration with a vulnerability database for accurate identification and classification of findings.
    * Potential to leverage or integrate with aspects of established open-source tools like OWASP ZAP.

2.  **Comprehensive Reporting:**
    * Generation of detailed reports outlining discovered vulnerabilities, their severity, potential impact, and guidance for remediation.
    * Data visualization features within reports to provide an intuitive understanding of the security posture of the scanned application.

3.  **User-Friendly Interface:**
    * An accessible interface for users to configure scan parameters (e.g., target URLs), initiate scans, and manage/view generated reports.

4.  **Agile Development & Extensibility:**
    * The project is developed using an Agile methodology, emphasizing iterative development cycles and continuous feedback.
    * The tool is designed to be modular and extensible, allowing for future enhancements and integrations with other security tools or platforms.

This project addresses the critical need for robust web application security by providing an efficient and effective tool for vulnerability assessment and management, ultimately contributing to a stronger security posture for organizations.

##  **Scope: Vulnerability Scanning & Reporting Tool** 
This project encompasses the design, development, and testing of an advanced **Vulnerability Scanning & Reporting Tool**. The primary focus is to enhance organizational cybersecurity defenses by automating the identification of security weaknesses within **web applications** and providing actionable reports.

### Systems & Applications Targeted for Scanning:

* The tool is specifically engineered to analyze and identify vulnerabilities in **web applications**. This includes dynamic websites, web services, and other web-based platforms. The tool's efficacy will be tested against vulnerable web applications such as DVWA, JuiceShop, and WebGoat.

### Core Components & Functionalities of the Developed Tool:

* **Vulnerability Scanning Engine:** This is the central component responsible for actively probing target web applications to detect potential security flaws. It will involve integrating or interacting with a vulnerability database to identify known weaknesses. The architecture considers leveraging elements or data from existing open-source tools like OWASP ZAP.
* **Reporting Module:** This component will process the findings from the scanning engine to generate comprehensive and detailed security reports. It will include features for data visualization to help users understand the identified vulnerabilities and their potential impact.
* **User Interface (UI):** A user-friendly interface will be developed to allow users to configure scan targets and parameters, initiate scans, and view/manage the generated vulnerability reports.
* **Vulnerability Database Integration:** The scanning engine will be integrated with a database of vulnerabilities to ensure accurate identification and classification of weaknesses discovered in the target web applications.

### Security Domain & Vulnerabilities Covered:

* The tool's primary focus is on **web application security vulnerabilities**. This includes, but is not limited to, common vulnerabilities such as those outlined in the OWASP Top 10 (e.g., injection flaws, cross-site scripting (XSS), broken authentication, security misconfigurations).
* While the materials list includes the Metasploit Framework, its use within this project's scope would likely be for specific web application penetration testing techniques or proof-of-concept generation related to web vulnerabilities, rather than general network or system-level scanning.

### Explicitly Out of Scope for this Project:

* Scanning and vulnerability assessment of non-web application infrastructure such as general network devices (routers, switches), operating systems (unless directly tied to a web application vulnerability), standalone desktop applications, or broad IoT ecosystems.
* The development of endpoint protection capabilities (e.g., antivirus, EDR for user workstations).
* Comprehensive cloud security posture management (CSPM) for cloud infrastructure (e.g., AWS, Azure, GCP configurations), beyond the security of the web applications hosted within such environments.
* Automated exploitation or remediation of identified vulnerabilities; the tool is designed for identification, reporting, and assisting mitigation efforts.
* Physical security assessments.



## Deliverables

This project, the "Vulnerability Scanning & Reporting Tool," will produce the following key deliverables as outlined in the initial project prompt and detailed in the project proposal:

1.  **Group Project Presentation:**
    * A presentation (maximum 15 minutes) showcasing the project's objectives, design, functionality, and outcomes. Screenshots of code or terminal output will be cropped for clarity and readability.

2.  **Group Project Report (GitHub Wiki):**
    * A comprehensive report hosted on the GitHub Wiki. This will detail:
        * **Requirements Document:** Outlining the defined scope, target vulnerabilities, and desired features.
        * **Tool Evaluation Report:** Documenting the evaluation of existing scanners for potential integration.
        * **Design and Architecture:** Describing the tool's structure, including the scanning engine, reporting module, and user interface.
        * **Development Process:** Overview of the development stages and key decisions made.
        * **Testing Strategy and Results:** Detailing the testing conducted to ensure accuracy, efficiency, and reliability, including user feedback integration.
        * **Finalized Tool Overview:** Description of the completed tool and its capabilities.

3.  **GitHub Project with Agile Artifacts:**
    * A GitHub Project board utilized for Agile project management, tracking:
        * **User Stories:** Clearly defined user stories following the "As a..., I want..., so that..." format, capturing requirements from different user perspectives.
        * **Issues:** Documenting specific features, enhancements, bugs, and other work items.
        * **Tasks:** Granular tasks assigned per team member, breaking down user stories and issues into actionable steps.
        * **Estimations:** Each issue/user story will include estimated priority, time, and complexity to evaluate contributions.
    * Milestones will be used to represent project phases or sprints.

4.  **GitHub Repository:**
    * The complete source code for the "Vulnerability Scanning & Reporting Tool," organized logically.
    * A `README.md` file providing an overview of the project, setup instructions, and usage guidelines for the tool.
    * All associated development files and documentation.

## Repository Structure

/ (root)

├── README.md         # Project overview, setup instructions, and documentation links

├── /src              # Source code organized by modules/features

├── /docs             # Additional documentation (design diagrams, user guides, etc.)

├── /tests            # Test scripts and sample data

├── .github

│   ├── ISSUE_TEMPLATE.md    # Template for bug/issue reports

│   └── PULL_REQUEST_TEMPLATE.md  # Guidelines for contributing

└── LICENSE

## Setup & Installation

This section provides instructions on how to set up the "Vulnerability Scanning & Reporting Tool" environment and get the application running.

### 1. Prerequisites:

Before you begin, ensure you have the following software and configurations:

* **Git:** For cloning the repository.
* **Python:** Version X.X.X or higher (e.g., Python 3.8+). Please specify the exact version used.
    * `pip` (Python package installer) is also required and usually comes with Python.
* **(Optional but Recommended for Testing) Docker:** For easily setting up vulnerable web application targets like DVWA, JuiceShop, or WebGoat.
* **(Potentially Required) OWASP ZAP:** If the tool directly integrates with OWASP ZAP for its scanning capabilities, specify the required version and if it needs to be running or accessible via API.
    * *Note to developers: Clarify if ZAP is a core runtime dependency or an optional integration.*
* **(Potentially Required) Metasploit Framework:** If the tool leverages Metasploit components, specify the requirements.
    * *Note to developers: Clarify if Metasploit is a core runtime dependency.*
* **Web Browser:** A modern web browser (e.g., Chrome, Firefox) for viewing the UI (if web-based) or HTML reports.
* **Operating System:** Specify compatible OS (e.g., Linux, macOS, Windows).

### 2. Installation Steps:

1.  **Clone the Repository:**
    ```bash
    git clone <your-repository-url>
    cd <repository-name>
    ```
    *Note to developers: Replace `<your-repository-url>` and `<repository-name>` with actual values.*

2.  **Set up Python Virtual Environment (Recommended):**
    ```bash
    python -m venv venv
    # On Windows
    .\venv\Scripts\activate
    # On macOS/Linux
    source venv/bin/activate
    ```

3.  **Install Dependencies:**
    Ensure you have a `requirements.txt` file listing all Python dependencies.
    ```bash
    pip install -r requirements.txt
    ```
    *Note to developers: If using a different package manager or language, adjust these steps accordingly (e.g., `npm install` for Node.js).*

4.  **(If Applicable) Configure External Tools:**
    * If OWASP ZAP or Metasploit are required, provide brief instructions or links to their installation guides.
    * Specify any configuration needed within this project to connect to these tools (e.g., API keys, paths in a config file).

### 3. Usage:

1.  **Running the Application:**
    Provide the command to start the main application.
    *Example (if it's a Python script named `main.py`):*
    ```bash
    python main.py
    ```
    *Note to developers: Specify the actual command, including any necessary arguments or if it's run through a different entry point (e.g., a specific command for a web framework like Flask or Django).*

2.  **Accessing the User Interface:**
    * If the tool has a web-based UI, specify the URL (e.g., `http://localhost:5000`).

3.  **Configuring a Scan:**
    * Briefly explain how a user initiates a scan (e.g., "Navigate to the 'New Scan' section in the UI, enter the target web application URL, and select scan parameters.").

4.  **Viewing Reports:**
    * Explain how users can access and view the generated vulnerability reports.

5.  **Testing Against Vulnerable Applications (Optional):**
    * If you want to test the scanner against known vulnerable applications like DVWA or JuiceShop:
        * **Using Docker (Example for DVWA):**
            ```bash
            docker pull vulnerables/web-dvwa
            docker run --rm -it -p 80:80 vulnerables/web-dvwa
            ```
            Access DVWA at `http://localhost`. Login with default credentials (admin/password).
        * *Note to developers: Provide similar quick start commands for other test applications if relevant, or link to their official setup guides.*
        * Then, use the scanner tool to target `http://localhost` or the specific IP/port of the running vulnerable application.

---
*Developers: Please fill in the placeholder details (X.X.X, `<your-repository-url>`, specific commands, configurations, etc.) to accurately reflect your project's setup.*

## Contribution Guidelines

As this project is a collaborative effort for the Spring 2025 Computer Systems Security course, the following guidelines are established to ensure smooth development and effective teamwork between Daniel Critchlow Jr. and Carlos Rodriguez. For any future contributors or if this project were to extend beyond the course, these guidelines would serve as a foundational set of practices.

1.  **Code Development:**
    * **Coding Standards:** Adhere to consistent coding standards relevant to the primary programming language(s) used (e.g., PEP 8 for Python). Strive for clear, readable, and maintainable code.
    * **Comments:** Add comments to explain complex logic, non-obvious decisions, or to document functions and classes.
    * **Testing:** Write unit tests or integration tests for new functionalities where appropriate to ensure stability and correctness.

2.  **Version Control (Git & GitHub):**
    * **Branching Strategy:**
        * Use feature branches for developing new functionalities or fixing bugs (e.g., `feature/user-authentication`, `fix/report-generation-bug`).
        * Create branches from the `main` or `develop` branch (specify which is the primary development branch).
        * Keep branches focused and relatively short-lived.
    * **Commits:**
        * Make small, logical commits with clear and concise commit messages (e.g., "Feat: Add user registration endpoint", "Fix: Correct calculation in report summary").
        * Reference relevant issue numbers in commit messages (e.g., "Closes #15").
    * **Pull Requests (PRs):**
        * Before merging into the main development branch, submit a Pull Request.
        * Ensure the PR description clearly outlines the changes made and the purpose of the PR.
        * Link PRs to the issues they resolve.
        * At least one other team member should review the PR before merging (for this project, the other teammate).
    * **Main Branch Protection:** The `main` branch should be kept stable and deployable. Direct pushes to `main` should be restricted if possible; all changes should come through reviewed PRs.

3.  **Agile Project Management (GitHub Project & Issues):**
    * **Issue Tracking:**
        * Create issues for all user stories, tasks, bugs, and feature enhancements.
        * Use the format specified in `User_Story_Format.md` for user stories.
        * Assign issues to the team member responsible.
        * Keep issue statuses updated on the GitHub Project board.
    * **GitHub Project Board:**
        * Regularly update the GitHub Project board by moving issues/tasks through columns (e.g., "To Do," "In Progress," "In Review," "Done") as work progresses.
    * **Milestones:** Use milestones to track progress towards major project phases or "sprints."

4.  **Documentation (GitHub Wiki & README):**
    * **README.md:** Keep the `README.md` updated with the project overview, setup instructions, and usage guidelines.
    * **GitHub Wiki:** Document design decisions, detailed explanations of modules, meeting notes, progress updates, and testing results in the GitHub Wiki as per the project report deliverables.
    * Update documentation as new features are added or existing ones change.

5.  **Communication:**
    * Attend regular team meetings to discuss progress, challenges, and plan next steps, as noted in the project proposal.
    * Use GitHub issue comments for discussions related to specific tasks or bugs.
    * For urgent or broader discussions, use the agreed-upon team communication channel (e.g., Slack, Discord, email).

By following these guidelines, we aim to maintain a well-organized, understandable, and high-quality project.

## Testing & Validation

Thorough testing and validation are critical to ensure the "Vulnerability Scanning & Reporting Tool" is accurate, efficient, and reliable, as outlined in Milestone 5 of the project proposal. Our testing strategy incorporates both automated checks (where applicable) and comprehensive manual testing procedures.

### 1. Automated Testing:

* **Unit Tests:**
    * *Description:* We will aim to implement unit tests for core individual functions and modules of the scanning engine, reporting module, and potentially UI components. This involves testing small, isolated pieces of code to verify they behave as expected given specific inputs.
    * *Tools/Frameworks:* *(Developers: Specify the testing framework used, e.g., `pytest` for Python, `unittest` for Python, `JUnit` for Java, `Jest` or `Mocha` for JavaScript/Node.js).*
    * *Execution:* These tests will be run regularly during development to catch regressions early.
    * *Example Script/Procedure:* *(Developers: Briefly describe how to run these tests, e.g., `pytest tests/unit` or mention if they are part of a CI pipeline).*

* **Integration Tests (Limited Scope):**
    * *Description:* Where feasible, integration tests will be developed to verify the interaction between key components, such as the scanning engine's ability to correctly pass data to the reporting module.
    * *Tools/Frameworks:* *(Developers: Specify tools if any, or if this is primarily verified through manual end-to-end testing).*
    * *Execution:* Run after major component integrations.

* *(Developers: Add any other automated tests planned or implemented, e.g., linting, static analysis checks).*

### 2. Manual Testing:

Manual testing forms a significant part of our validation process, especially for assessing the scanner's effectiveness against known vulnerable applications and verifying the end-user experience.

* **Target Test Environments:**
    * **OWASP Damn Vulnerable Web Application (DVWA):** Used to test the scanner's ability to detect a wide range of common web vulnerabilities (SQL Injection, XSS, Command Injection, CSRF, File Inclusion, etc.) at various difficulty levels.
    * **OWASP Juice Shop:** A modern and complex vulnerable web application used to test the scanner against more sophisticated vulnerabilities and newer web technologies.
    * **OWASP WebGoat:** Another educational tool used to test the detection of specific OWASP Top 10 vulnerabilities.
    * *(Developers: Add any other specific target applications or custom testbeds used).*

* **Manual Testing Procedures & Expected Outcomes:**

    1.  **Scanner Functionality Testing:**
        * **Procedure:**
            1.  Set up one of the target vulnerable applications (DVWA, Juice Shop, WebGoat).
            2.  Configure the "Vulnerability Scanning & Reporting Tool" to scan the target application's URL.
            3.  Initiate the scan with various configurations (e.g., different scan intensities, specific vulnerability checks if configurable).
            4.  Monitor the scan progress and tool stability during the scan.
        * **Expected Outcome:**
            * The tool successfully completes scans without crashing or significant errors.
            * The tool identifies known vulnerabilities present in the target applications (cross-referenced with DVWA/Juice Shop documentation or manual verification).
            * Minimize false positives (reporting vulnerabilities that don't exist) and false negatives (failing to detect actual vulnerabilities).

    2.  **Reporting Module Validation:**
        * **Procedure:**
            1.  After a scan completes, access the generated report through the UI or exported file.
            2.  Verify that all identified vulnerabilities are listed accurately.
            3.  Check for completeness of information (e.g., vulnerability description, severity, affected URL/parameter, suggested remediation).
            4.  Validate data visualization features for clarity and correctness.
        * **Expected Outcome:** Reports are comprehensive, accurate, easy to understand, and provide actionable information. Data visualizations correctly represent the scan findings.

    3.  **User Interface (UI) Testing:**
        * **Procedure:**
            1.  Navigate through all sections of the UI.
            2.  Test all interactive elements (buttons, forms, input fields) for responsiveness and correct behavior.
            3.  Verify ease of use for configuring scans, viewing results, and accessing help/documentation.
            4.  Test on different browsers (if web-based) and screen resolutions if applicable.
        * **Expected Outcome:** The UI is intuitive, user-friendly, responsive, and free of critical usability issues.

    4.  **False Positive/Negative Analysis:**
        * **Procedure:** For each vulnerability reported by the tool on a test application, manually attempt to verify its existence. For known vulnerabilities in the test applications that the tool *doesn't* find, investigate why.
        * **Expected Outcome:** A documented understanding of the tool's accuracy, with efforts made during refinement (Milestone 5) to reduce false positives and negatives.

* **User Feedback Integration:**
    * As per Milestone 5, the tool will be deployed in a controlled environment for initial use. Feedback from this phase will be crucial for identifying bugs, usability issues, and areas for refinement. This feedback will be documented and used to validate and improve the tool.

*(Developers: This section should be updated with specific test cases, actual results, and details of any automated scripts as the project progresses and testing is performed. Include links to any test plans or results documented in the GitHub Wiki if applicable.)*

## License

This project, the "Vulnerability Scanning & Reporting Tool," is licensed under the **MIT License**.

A copy of the MIT License should be included in the root of the repository in a file named `LICENSE` or `LICENSE.md`.

The MIT License is a permissive free software license originating at the Massachusetts Institute of Technology (MIT). As a permissive license, it puts only very limited restrictions on reuse and has, therefore, high license compatibility.

Essentially, this means:

* **You are free to:**
    * Use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the software.
* **Under the following conditions:**
    * The above copyright notice (usually "Copyright (c) [Year] [Full Name]") and this permission notice shall be included in all copies or substantial portions of the Software.

The software is provided "AS IS", without warranty of any kind, express or implied.

**(Developers: Ensure a `LICENSE` file with the full text of the MIT License and your copyright information is present in your GitHub repository.)**

Example `LICENSE` file content:
```MIT License

Copyright (c) 2025 Daniel Critchlow Jr. & Carlos Rodriguez

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
blog.risingstack.com
blog.risingstack.com
github.com
github.com
github.com
github.com
Project_Pr...pring_2025
PDF icon
PDF
User_Story_Format
MD icon
MD
```

## Additional Notes

This section highlights project-specific considerations, potential future enhancements for the "Vulnerability Scanning & Reporting Tool," and any known issues at the current stage.

### Project-Specific Considerations:

* **Academic Context:** This tool was developed as a group project for the Computer Systems Security course (Spring 2025). As such, its scope and timeline were aligned with academic requirements and deliverables.
* **Agile Methodology:** As stated in the project proposal, an Agile methodology was adopted, emphasizing iterative development and continuous feedback. Regular team meetings were conducted to track progress, discuss challenges, and ensure alignment with project goals.
* **Retroactive Agile Documentation:** Some Agile artifacts (user stories, tasks, project board population) were created or refined retroactively to ensure comprehensive documentation of the work performed throughout the semester.
* **Materials Leverage:** The project considered tools like OWASP ZAP and Metasploit (from the Materials List) primarily as references for understanding vulnerability types, potential integration points for a scanning engine, or as established tools to compare against. The core of this project is the development of a *new* tool, not just a wrapper for existing ones.

### Future Enhancements:

The modular and extensible design of the tool, as mentioned in the proposal, allows for several potential future enhancements:

* **Expanded Vulnerability Coverage:**
    * Integration of more advanced scanning techniques for a wider array of web vulnerabilities, including those specific to modern frameworks (e.g., SPAs, server-side request forgery).
    * Support for authenticated scans (requiring user credentials to scan restricted areas of web applications).
* **Enhanced Reporting & Analytics:**
    * Customizable report templates and export formats (e.g., JSON, XML for easier integration with other systems).
    * Trend analysis to track vulnerability remediation progress over time.
    * Integration with issue tracking systems (e.g., JIRA, or deeper GitHub Issues integration) to automatically create tickets for identified vulnerabilities.
* **Improved Scan Configuration:**
    * Scan scheduling capabilities for automated periodic assessments.
    * More granular control over scan intensity and specific tests to be performed.
    * Support for defining scan policies.
* **Broader Platform Support (Long-Term):**
    * While currently focused on web applications, future iterations could explore modules for API scanning or basic infrastructure checks if aligned with an expanded scope.
* **Machine Learning (ML) Integration:**
    * Investigate the use of ML for improving the accuracy of vulnerability detection, reducing false positives, or prioritizing vulnerabilities based on contextual risk.
* **User Management & Roles:**
    * For a multi-user environment, adding user roles and permissions for accessing scan configurations and reports.

### Known Issues & Limitations (as of May 2025):

*(Developers: This is a critical section to fill out honestly based on the state of your project. It shows self-awareness and thoroughness.)*

* **Example Issue 1:** The scanning engine may currently have a higher rate of false positives for certain types of reflected XSS vulnerabilities in applications using specific client-side rendering frameworks. Further refinement of the detection logic is needed.
* **Example Issue 2:** Performance for scanning very large web applications (e.g., >10,000 pages) has not been extensively benchmarked and may require optimization.
* **Example Issue 3:** The current UI is functional but lacks advanced features like detailed scan progress indicators or on-the-fly report filtering.
* **Example Limitation 1:** The tool does not currently support scans that require complex multi-step authentication flows (e.g., SSO, MFA challenges beyond simple login forms).
* **Example Limitation 2:** Automated remediation of vulnerabilities is explicitly out of scope. The tool provides information to *assist* manual remediation.

*(Please update this section with specific details relevant to the final state of your project for the Spring 2025 submission.)*
