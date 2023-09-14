program health_record.aleo;

struct HealthInfo:
    content as field;
    issuer as address;

record HealthRecord:
    owner as address.private;
    id as field.private;


mapping healths:
	key left as field.public;
	value right as HealthInfo.public;

function issue:
    input r0 as HealthInfo.public;
    input r1 as address.private;
    assert.eq self.caller r0.issuer;
    hash.bhp256 r0.content into r2 as field;
    cast r1 r2 into r3 as HealthRecord.record;
    output r3 as HealthRecord.record;

    finalize r2 r0;

finalize issue:
    input r0 as field.public;
    input r1 as HealthInfo.public;
    set r1 into healths[r0];
