// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JobPosting {
    struct Job {
        uint256 id;
        string title;
        string description;
        address employer;
        address applicant;
        bool isOpen;
    }

    mapping(uint256 => Job) public jobs;
    uint256 public jobCount;

    event JobPosted(uint256 jobId, string title, address employer);
    event JobApplied(uint256 jobId, address applicant);

    function postJob(string memory _title, string memory _description) public {
        jobCount++;
        jobs[jobCount] = Job(jobCount, _title, _description, msg.sender, address(0), true);
        emit JobPosted(jobCount, _title, msg.sender);
    }

    function applyForJob(uint256 _jobId) public {
        require(jobs[_jobId].isOpen, "Job is no longer open");
        require(jobs[_jobId].applicant == address(0), "Job already has an applicant");

        jobs[_jobId].applicant = msg.sender;
        jobs[_jobId].isOpen = false;
        emit JobApplied(_jobId, msg.sender);
    }

    function getJob(uint256 _jobId) public view returns (string memory, string memory, address, address, bool) {
        Job memory job = jobs[_jobId];
        return (job.title, job.description, job.employer, job.applicant, job.isOpen);
    }
}
