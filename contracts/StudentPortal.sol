// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.26;

contract StudentPortal {
    address private owner;

    struct Student {
        string name;
        string email;
        string dob;
        string country;
        string state;
        string lga;
    }
    mapping(uint32 => Student) students;

    modifier auth() {
        require(
            msg.sender == owner,
            "Forbidden:: You can not perform this action"
        );
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function register(
        uint32 _id,
        string memory name,
        string memory email,
        string memory dob,
        string memory country,
        string memory state,
        string memory lga
    ) external auth {
        students[_id] = Student(name, email, dob, country, state, lga);
    }

    function getStudent(uint32 _id) external view returns (Student memory) {
        return students[_id];
    }

    function updateStudent(uint32 _id, Student memory newRecord) external auth {
        if (bytes(newRecord.name).length > 0) {
            students[_id].name = newRecord.name;
        }
        if (bytes(newRecord.email).length > 0) {
            students[_id].email = newRecord.email;
        }
        if (bytes(newRecord.dob).length > 0) {
            students[_id].dob = newRecord.dob;
        }
        if (bytes(newRecord.country).length > 0) {
            students[_id].country = newRecord.country;
        }
        if (bytes(newRecord.state).length > 0) {
            students[_id].state = newRecord.state;
        }
        if (bytes(newRecord.lga).length > 0) {
            students[_id].lga = newRecord.lga;
        }
    }

    function deleteStudent(uint32 _id) external auth {
        delete students[_id];
    }
}
