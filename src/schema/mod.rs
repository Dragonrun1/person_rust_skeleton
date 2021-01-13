table! {
    use diesel::sql_types::*;
    use uuid64rs::Uuid4Proxy;

    genders (id) {
        id -> Uuid4Proxy,
        gender_identity -> Nullable<Varchar>,
        sex -> Varchar,
        #[cfg(feature = "created_at")]
        created_at -> Datetime,
        #[cfg(feature = "updated_at")]
        updated_at -> Nullable<Datetime>,
        #[cfg(feature = "updated_by")]
        updated_by -> Nullable<Uuid4Proxy>,
    }
}

table! {
    use diesel::sql_types::*;
    use uuid64rs::Uuid4Proxy;

    people (id) {
        id -> Uuid4Proxy,
        additional_name -> Nullable<Varchar>,
        birthday -> Nullable<Datetime>,
        family_name -> Varchar,
        gender_id -> Nullable<Uuid4Proxy>,
        given_name -> Varchar,
        honorific_prefix -> Nullable<Varchar>,
        honorific_suffix -> Nullable<Varchar>,
        pronoun_id -> Nullable<Uuid4Proxy>,
        #[cfg(feature = "created_at")]
        created_at -> Datetime,
        #[cfg(feature = "updated_at")]
        updated_at -> Nullable<Datetime>,
        #[cfg(feature = "updated_by")]
        updated_by -> Nullable<Uuid4Proxy>,
    }
}

table! {
    use diesel::sql_types::*;
    use uuid64rs::Uuid4Proxy;

    pronouns (id) {
        id -> Uuid4Proxy,
        object -> Varchar,
        possessive -> Varchar,
        subject -> Varchar,
        #[cfg(feature = "created_at")]
        created_at -> Datetime,
        #[cfg(feature = "updated_at")]
        updated_at -> Nullable<Datetime>,
        #[cfg(feature = "updated_by")]
        updated_by -> Nullable<Uuid4Proxy>,
    }
}

allow_tables_to_appear_in_same_query!(genders, people, pronouns,);
