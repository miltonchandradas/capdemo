// eslint-disable-next-line
const colors = require("colors");

module.exports = srv => {
    srv.before("*", async req => {
        console.log(`Method: ${req.method}`.yellow.inverse);
        // console.log(`Target: ${JSON.stringify(req.target)}`.yellow.inverse);
    });

    srv.before("CREATE", async req => {
        const { age, role } = req.data;

        if (!_validateAge(age))
            return req.reject(400, "Age cannot be less than 21...");

        req.data.salary = _computeSalary(role);
        req.data.active = false;
    });

    srv.before("UPDATE", async (req) => {
        const { role } = req.data;

        if (role)
            req.data.salary = _computeSalary(role);

    });

};

function _validateAge(age) {

    if (!age || age < 21)
        return false;

    return true;
}

function _computeSalary(role) {
    if (role === "UX Developer") {
        return "7000";
    } else if (role === "UX Lead") {
        return "9000";
    } else
        return;
}