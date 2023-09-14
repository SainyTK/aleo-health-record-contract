// The 'health_record' program.
program health_record.aleo {

    // Public health record
    struct HealthInfo {
        content: field,
        issuer: address
    }

    // Private health record ownership
    record HealthRecord {
        owner: address,
        id: field,
    }

    // State
    mapping healths: field => HealthInfo;

    transition issue(
        public info: HealthInfo,
        patient: address
    ) -> HealthRecord {
        assert_eq(self.caller, info.issuer);

        let id: field = BHP256::hash_to_field(info.content);

        return HealthRecord {
          owner: patient,
          id
        } then finalize(id, info);
    }

    finalize issue(public id: field, public info: HealthInfo) {
        Mapping::set(healths, id, info);
    }

}

