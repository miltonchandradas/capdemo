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


    srv.on("setActive", async req => {
        console.log("Background check is complete...");
        console.log("Onboarding is complete...");

        const { ID } = req.data;
        console.log("ID: ", ID);
        const db = srv.transaction(req);

        let { UXTeam } = srv.entities;

        try {

            let result = await db.update(UXTeam).set({ active: true }).where({ ID: ID });
            console.log("Updated result: ", result);

            result = await db.read(UXTeam).where({ ID: ID });
            console.log("Updated result: ", result);

            return result;

        } catch (error) {
            console.log(JSON.stringify(error));
            return null;
        }

    });

    srv.on("getDATE", () => {
        return "2018-09-25";
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
