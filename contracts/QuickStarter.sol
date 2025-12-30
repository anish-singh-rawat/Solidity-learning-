// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract QuickStarter {
    struct Project {
        address owner;
        string title;
        uint256 goalAmount;
        uint256 totalRaised;
        bool isActive;
    }

    uint256 public projectCount;

    mapping(uint256 => Project) public projects;
    mapping(uint256 => mapping(address => uint256)) public investments;

    event ProjectCreated(
        uint256 projectId,
        address indexed owner,
        string title,
        uint256 goalAmount
    );

    event Invested(
        uint256 projectId,
        address indexed investor,
        uint256 amount
    );

    function createProject(
        string calldata _title,
        uint256 _goalAmount
    ) external {
        require(_goalAmount > 0, "Goal must be greater than 0");

        projectCount++;

        projects[projectCount] = Project({
            owner: msg.sender,
            title: _title,
            goalAmount: _goalAmount,
            totalRaised: 0,
            isActive: true
        });

        emit ProjectCreated(projectCount, msg.sender, _title, _goalAmount);
    }

    function invest(uint256 _projectId) external payable {
        Project storage project = projects[_projectId];

        require(project.isActive, "Project not active");
        require(msg.value > 0, "Investment must be > 0");

        project.totalRaised += msg.value;
        investments[_projectId][msg.sender] += msg.value;

        emit Invested(_projectId, msg.sender, msg.value);
    }

    function getProject(uint256 _projectId)
        external
        view
        returns (
            address owner,
            string memory title,
            uint256 goal,
            uint256 raised,
            bool active
        )
    {
        Project storage project = projects[_projectId];

        return (
            project.owner,
            project.title,
            project.goalAmount,
            project.totalRaised,
            project.isActive
        );
    }
}
