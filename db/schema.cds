namespace db;
using {cuid, managed} from '@sap/cds/common';

annotate db.UXTeam with @fiori.draft.enabled;
entity UXTeam : cuid, managed {
    firstName: String(100);
    lastName: String(100);
    age: Integer;
    role: String(100);
    @readonly
    @Semantics.amount.currencyCode: 'currency'
    salary: Decimal(9, 3);
    active: Boolean default false;
    @Semantics.currencyCode
    currency  : String(3) default 'USD';
}


