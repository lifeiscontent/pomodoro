namespace Pomodoro {
    public class InMemoryStore : Store {
        public override void add_task (Task to_add) {
            tasks.add (to_add);
            task_added (to_add);
        }

        public override void remove_task (Task to_remove) {
            tasks.remove (to_remove);
            task_removed (to_remove);
        }
    }
}
