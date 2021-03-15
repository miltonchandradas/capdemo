using {db} from '../db/schema';

service TechService {

    entity UXTeam as select from db.UXTeam;
    
    // function setActive(ID : String) returns UXTeam;
    function getDATE() returns Date;
}

// annotate TechService.UXTeam with @odata.draft.enabled;

annotate TechService.UXTeam with @odata.draft.enabled {
    ID        @(Common : {Label : 'ID'});
    firstName @(Common : {Label : 'First Name'});
    lastName  @(Common : {Label : 'Last Name'});
    age       @(Common : {Label : 'Age'});
    role      @(Common : {Label : 'Role'});
    salary    @(
        Common               : {Label : 'Salary'},
        Measures.ISOCurrency : currency
    );
    active    @(Common : {Label : 'Active'});
};

annotate TechService.UXTeam with @(UI : {
    HeaderInfo               : {
        TypeName       : 'UXTeam',
        TypeNamePlural : 'UXTeam',
        Title          : {
            $Type : 'UI.DataField',
            Value : ID
        }
    },
    SelectionFields          : [
    firstName,
    lastName,
    role
    ],
    LineItem                 : [
    { $Type: 'UI.DataFieldForAction', Action: 'TechService.setActive', Label: 'Set Active',  Visible, Enabled},
    {
        $Type : 'UI.DataField',
        Value : ID
    },
    {
        $Type : 'UI.DataField',
        Value : firstName
    },
    {
        $Type : 'UI.DataField',
        Value : lastName
    },
    {
        $Type : 'UI.DataField',
        Value : age
    },
    {
        $Type : 'UI.DataField',
        Value : role
    },
    {
        $Type : 'UI.DataField',
        Value : salary
    }
    ],
    HeaderFacets             : [{
        $Type  : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#UXTeamDetail',
        Label  : 'UXTeam Member'
    }],
    Facets                   : [{
        $Type  : 'UI.CollectionFacet',
        Label  : 'UXTeam Member',
        Facets : [{
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Description',
            Label  : 'UXTeam Member Details'
        }, ]
    }],
    FieldGroup #Description  : {Data : [
    {
        $Type : 'UI.DataField',
        Value : ID
    },
    {
        $Type : 'UI.DataField',
        Value : firstName
    },
    {
        $Type : 'UI.DataField',
        Value : lastName
    },
    {
        $Type : 'UI.DataField',
        Value : age
    },
    {
        $Type : 'UI.DataField',
        Value : role
    },
    {
        $Type : 'UI.DataField',
        Value : salary
    }
    ]},
    FieldGroup #UXTeamDetail : {Data : [
    {
        $Type : 'UI.DataField',
        Value : ID
    }
    ]}
});
