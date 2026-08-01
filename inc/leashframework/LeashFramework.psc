Scriptname LeashFramework Hidden

;/
Active leash factions supplied by Leash.esp:
- LeashedFaction (form ID 0x000D6A): contains actors that currently have an active leash.
- LeasherFaction (form ID 0x000D6B): contains actors that currently hold one or more active leashes.

Pull mod events:
- LeashFramework_OnActorPulled: sent once when normal direct-locomotion pulling starts.
- LeashFramework_OnActorRagdollPulled: sent once when forced ragdoll pulling starts.

Register with RegisterForModEvent. Both events use the leashed Actor as sender, leave strArg empty,
and provide the holder-to-collar distance at the transition in numArg. An event can be sent again only
after that pull mode stops and later starts again; it is not sent every frame while pulling remains active.
/;

;/
Connects a leash from a holder's right hand to leash bones on another actor.

holder: Actor holding the leash. The current attachment bone is NPC R Hand [RHnd].
leashed: Actor wearing the leash mesh. An actor can have only one active leash.
parentBone: Exact node name to find on the leashed actor before searching its descendants.
leashBoneMatch: Text found anywhere in each ordered leash bone name beneath parentBone. For example,
Main_ matches hdtSSEPhysics_AutoRename_Armor_00000004 Main_01 after SMP renames the node.
minLength: Distance where active leash pulling stops. Must be zero or greater.
maxLength: Maximum holder-to-collar distance. Must be positive and at least minLength.
persistent: When true, the leash is saved and restored until explicitly disconnected.

Applying another leash to the same leashed actor replaces its current leash.
Returns true when the arguments are valid and the leash is accepted.
/;
Bool Function ApplyLeash(Actor holder, Actor leashed, String parentBone, String leashBoneMatch, Float minLength, Float maxLength, Bool persistent) Global Native

;/
Disconnects the leash matching the specific holder and leashed actor.

holder: Actor holding the leash.
leashed: Actor wearing the leash mesh.

Returns true when the matching leash was disconnected.
/;
Bool Function DisconnectLeash(Actor holder, Actor leashed) Global Native

;/
Disconnects every leash where actor is either the holder or the leashed actor.

Returns true when at least one leash was disconnected.
/;
Bool Function UnleashAll(Actor actor) Global Native

;/
Returns true when actor currently has an active leash.
/;
Bool Function IsLeashed(Actor actor) Global Native

;/
Returns true when actor currently holds at least one active leash.
/;
Bool Function IsLeashHolder(Actor actor) Global Native

;/
Returns the actor holding leashed's active leash, or None when leashed has no active leash.
/;
Actor Function GetLeashHolder(Actor leashed) Global Native

;/
Returns every actor currently leashed to holder. Returns an empty array when holder has no active leashes.
/;
Actor[] Function GetLeashedActors(Actor holder) Global Native

;/
Returns the minimum length of leashed's active leash, or -1.0 when leashed has no active leash.
/;
Float Function GetMinLeashLength(Actor leashed) Global Native

;/
Returns the maximum length of leashed's active leash, or -1.0 when leashed has no active leash.
/;
Float Function GetMaxLeashLength(Actor leashed) Global Native

;/
Sets the minimum length of leashed's active leash.

newLength must be zero or greater and cannot exceed the current maximum length.
Returns false when leashed has no active leash or newLength is invalid.
/;
Bool Function SetMinLeashLength(Actor leashed, Float newLength) Global Native

;/
Sets the maximum length of leashed's active leash.

newLength must be positive and cannot be less than the current minimum length.
Returns false when leashed has no active leash or newLength is invalid.
/;
Bool Function SetMaxLeashLength(Actor leashed, Float newLength) Global Native
